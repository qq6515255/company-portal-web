# Company Portal - Windows Deploy Script (PowerShell)
param(
    [switch]$SkipBuild,
    [switch]$SkipEcs,
    [switch]$SkipOss,
    [switch]$SkipCdn
)

# Load .env
if (Test-Path ".env") {
    Write-Host "[INFO] Loading .env config..." -ForegroundColor Yellow
    Get-Content ".env" | Where-Object { $_ -notmatch "^#" -and $_ -match "=" } | ForEach-Object {
        $parts = $_.Split("=", 2)
        [Environment]::SetEnvironmentVariable($parts[0].Trim(), $parts[1].Trim(), "Process")
    }
} else {
    Write-Host "[ERROR] .env file not found" -ForegroundColor Red
    exit 1
}

$PROJECT_NAME = "company-portal-web"
$PROJECT_DIR = "/var/www/$PROJECT_NAME"

# 1. Build
function Do-Build {
    Write-Host ""
    Write-Host "========== [1/4] BUILD ==========" -ForegroundColor Green
    Write-Host "Installing dependencies..."
    npm install
    Write-Host "Running build..."
    npm run generate
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Build failed" -ForegroundColor Red
        exit 1
    }
    if (-not (Test-Path ".output/public")) {
        Write-Host "[ERROR] Build output not found" -ForegroundColor Red
        exit 1
    }
    Write-Host "[OK] Build completed" -ForegroundColor Green
}

# 2. ECS Deploy (SSH Key Auth)
function Do-Ecs {
    Write-Host ""
    Write-Host "========== [2/4] ECS DEPLOY ==========" -ForegroundColor Green
    $ecsHost = $env:ECS_HOST
    $ecsUser = $env:ECS_USER
    
    if (-not ($ecsHost -and $ecsUser)) {
        Write-Host "[SKIP] ECS config incomplete" -ForegroundColor Yellow
        return
    }
    
    Write-Host "ECS Host: $ecsUser@$ecsHost"
    Write-Host "Target Dir: $PROJECT_DIR"
    
    # Test SSH connection first
    Write-Host "Testing SSH connection..."
    $testResult = ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 $ecsUser@$ecsHost "echo OK" 2>&1
    if ($testResult -notmatch "OK") {
        Write-Host "[ERROR] SSH connection failed. Check your key configuration." -ForegroundColor Red
        return
    }
    Write-Host "[OK] SSH connection verified"
    
    # Create remote directory
    Write-Host "Creating remote directory..."
    ssh -o StrictHostKeyChecking=no $ecsUser@$ecsHost "mkdir -p ${PROJECT_DIR}"
    
    # Sync files via scp (key auth)
    Write-Host "Syncing files via scp..."
    scp -r -o StrictHostKeyChecking=no .output/public/* "${ecsUser}@${ecsHost}:${PROJECT_DIR}/"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] ECS deploy completed" -ForegroundColor Green
        Write-Host "[INFO] Files deployed to: ${ecsUser}@${ecsHost}:${PROJECT_DIR}" -ForegroundColor Cyan
    } else {
        Write-Host "[ERROR] ECS deploy failed" -ForegroundColor Red
    }
}

# 3. OSS Upload
function Do-Oss {
    Write-Host ""
    Write-Host "========== [3/4] OSS UPLOAD ==========" -ForegroundColor Green
    $bucket = $env:OSS_BUCKET
    $keyId = $env:OSS_ACCESS_KEY_ID
    $keySecret = $env:OSS_ACCESS_KEY_SECRET
    $region = if ($env:OSS_REGION) { $env:OSS_REGION } else { "oss-cn-hangzhou" }
    
    if (-not ($bucket -and $keyId -and $keySecret)) {
        Write-Host "[SKIP] OSS config incomplete" -ForegroundColor Yellow
        return
    }
    
    Write-Host "Bucket: $bucket"
    Write-Host "Region: $region"
    
    # Find ossutil
    $ossutil = "ossutil64.exe"
    $found = $false
    foreach ($dir in @("$env:TEMP", "C:\ossutil", $env:LOCALAPPDATA)) {
        $testPath = Join-Path $dir "ossutil64.exe"
        if (Test-Path $testPath) {
            $ossutil = $testPath
            $found = $true
            break
        }
    }
    
    if (-not $found) {
        Write-Host "Downloading ossutil..."
        $ossutil = "$env:TEMP\ossutil64.exe"
        try {
            Invoke-WebRequest -Uri "https://gosspublic.alicdn.com/ossutil/ossutil-v1.7.14/ossutil64.exe" -OutFile $ossutil -TimeoutSec 60
        } catch {
            Write-Host "[ERROR] Failed to download ossutil" -ForegroundColor Red
            return
        }
    }
    
    Write-Host "Using ossutil: $ossutil"
    
    # Configure ossutil
    Write-Host "Configuring ossutil..."
    & $ossutil config -i $keyId -k $keySecret -e "${region}.aliyuncs.com" 2>&1 | Out-Null
    
    # Upload to OSS
    Write-Host "Uploading to OSS..."
    & $ossutil cp -r .output/public oss://$bucket/ --force --retry-times=3
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] OSS upload completed" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] OSS upload failed" -ForegroundColor Red
    }
}

# 4. CDN Refresh
function Do-Cdn {
    Write-Host ""
    Write-Host "========== [4/4] CDN REFRESH ==========" -ForegroundColor Green
    $domain = $env:CDN_DOMAIN
    $keyId = $env:OSS_ACCESS_KEY_ID
    $keySecret = $env:OSS_ACCESS_KEY_SECRET
    
    if (-not ($domain -and $keyId -and $keySecret)) {
        Write-Host "[SKIP] CDN config incomplete" -ForegroundColor Yellow
        return
    }
    
    Write-Host "CDN Domain: $domain"
    
    # Find aliyun CLI
    $aliyun = Get-Command aliyun -ErrorAction SilentlyContinue
    if (-not $aliyun) {
        Write-Host "[SKIP] aliyun CLI not found" -ForegroundColor Yellow
        return
    }
    
    Write-Host "Refreshing CDN..."
    $result = & aliyun cdn PushObjectCache --ObjectPath "$domain/" --ObjectType directory --Area mainland 2>&1
    
    if ($result -match "RequestId") {
        Write-Host "[OK] CDN refresh completed" -ForegroundColor Green
    } else {
        Write-Host "[WARN] CDN result: $result" -ForegroundColor Yellow
    }
}

# Main
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  Company Portal - Deploy Script" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Project: $env:SITE_NAME"
Write-Host "URL:     $env:SITE_URL"
Write-Host ""

# Show deploy options
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Deploy Options" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  1. Build        : $(if ($SkipBuild) { 'SKIP' } else { 'EXECUTE' })"
Write-Host "  2. ECS Deploy   : $(if ($SkipEcs) { 'SKIP' } else { 'EXECUTE' })"
Write-Host "  3. OSS Upload   : $(if ($SkipOss) { 'SKIP' } else { 'EXECUTE' })"
Write-Host "  4. CDN Refresh  : $(if ($SkipCdn) { 'SKIP' } else { 'EXECUTE' })"
Write-Host ""
Write-Host "Use flags to skip steps: -SkipBuild -SkipEcs -SkipOss -SkipCdn"
Write-Host ""

# Execute steps
if (-not $SkipBuild) { Do-Build }
if (-not $SkipEcs) { Do-Ecs }
if (-not $SkipOss) { Do-Oss }
if (-not $SkipCdn) { Do-Cdn }

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  Deploy Completed" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
