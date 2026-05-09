create extension if not exists pgcrypto;

create table if not exists public.contact_leads (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  company text not null,
  phone text not null,
  email text not null,
  message text not null,
  source_page text not null default '/contact',
  location_lat double precision,
  location_lng double precision,
  location_accuracy double precision,
  location_source text,
  location_collected_at timestamptz,
  location_address text,
  status text not null default 'new' check (status in ('new', 'emailed', 'email_failed')),
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists contact_leads_created_at_idx
  on public.contact_leads (created_at desc);

create index if not exists contact_leads_status_idx
  on public.contact_leads (status);

alter table public.contact_leads enable row level security;

revoke all on public.contact_leads from anon;
revoke all on public.contact_leads from authenticated;

comment on table public.contact_leads is '官网联系表单线索';
comment on column public.contact_leads.location_lat is '浏览器定位纬度';
comment on column public.contact_leads.location_lng is '浏览器定位经度';
comment on column public.contact_leads.location_accuracy is '浏览器定位精度（米）';
