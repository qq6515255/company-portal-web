export interface Product {
  id: string
  name: string
  category: string
  desc: string
  spec: string
  image: string
  detailDesc: string
  features: string[]
  applications: string[]
}

const productDefinitions: Product[] = [
  {
    id: 'zhenzhumian',
    name: '珍珠棉',
    category: '缓冲材料',
    desc: '高性能缓冲防震材料，柔韧性好，适合电子、家具、玻璃等产品的包装防护',
    spec: '厚度: 0.5-50mm',
    image: '/images/products/pearl-cotton.jpg',
    detailDesc: '珍珠棉（EPE）是一种新型环保的包装材料，由低密度聚乙烯脂经物理发泡产生无数的独立气泡构成。具有隔水防潮、防静电、防震、隔音、保温、可塑性能佳、韧性强、循环再造、环保、抗撞力强等诸多优点，是传统包装材料的理想替代品。',
    features: ['优异的缓冲防震性能', '柔韧性强，不易断裂', '可反复回收利用', '防静电处理可选', '无毒无味，环保安全'],
    applications: ['电子产品包装', '家具运输防护', '玻璃制品缓冲', '工艺品包装', '医疗器械防护']
  },
  {
    id: 'paomomian',
    name: '泡沫棉',
    category: '缓冲材料',
    desc: '轻质缓冲材料，隔音隔热防震，适用于多种产品的包装填充',
    spec: '密度: 10-50kg/m³',
    image: '/images/products/eva-foam.jpg',
    detailDesc: '泡沫棉采用聚苯乙烯（EPS）或聚氨酯（PU）为原料，具有质轻、隔热、吸音、减震等特性。广泛应用于建筑、家电、冷链物流等领域的缓冲包装和保温隔热。',
    features: ['超轻质，降低运输成本', '优异的隔热保温性能', '良好的吸音降噪效果', '抗压强度高', '成本经济实用'],
    applications: ['家电产品包装', '冷链物流保温箱', '建筑保温材料', '精密仪器缓冲', '易碎品填充保护']
  },
  {
    id: 'eva-paomian',
    name: 'EVA泡棉',
    category: '缓冲材料',
    desc: '高弹性EVA材料，防水防震，广泛用于鞋材、箱包、电子产品',
    spec: '硬度: 20-60度',
    image: '/images/products/foam-material.jpg',
    detailDesc: 'EVA（乙烯-醋酸乙烯共聚物）泡棉是一种具有优异弹性和缓冲性能的新型材料。具有柔软性好、防震防滑、耐化学腐蚀、色彩丰富等特点，是现代工业和消费品领域的重要材料。',
    features: ['高弹性，回弹迅速', '优异的防水防潮性能', '耐油耐化学腐蚀', '色彩可定制', '环保无毒'],
    applications: ['鞋材中底垫', '箱包内衬', '运动护具', '电子产品防震垫', '汽车内饰件']
  },
  {
    id: 'touming-jiaodai',
    name: '透明胶带',
    category: '粘接材料',
    desc: '高透明度胶带，粘性强不残胶，适用于包装封箱、办公等',
    spec: '宽度: 12-72mm',
    image: '/images/products/adhesive-tape.jpg',
    detailDesc: '透明胶带以BOPP薄膜为基材，涂覆高性能压敏胶制成。具有高透明度、粘性强、不残胶、耐候性好等特点。是纸箱封口、物品固定、办公文具的必备材料。',
    features: ['高透明度，美观大方', '粘性强，持久不脱落', '撕拉顺畅，不易断裂', '不残胶，保护被粘表面', '耐温范围广'],
    applications: ['纸箱封箱打包', '快递物流包装', '办公文件封装', '商品标签固定', '临时物品固定']
  },
  {
    id: 'shuangmian-jiaodai',
    name: '双面胶带',
    category: '粘接材料',
    desc: '强粘性双面胶，固定、拼接、修补多功能应用',
    spec: '粘性: 高/中/低',
    image: '/images/products/double-sided-tape.jpg',
    detailDesc: '双面胶带两面涂覆高性能压敏胶，中间以棉纸、PET膜或无纺布为基材。具有粘性强、厚度均匀、易模切等特点。适用于物品固定、拼接、修补等多种场景。',
    features: ['双面强粘，牢固可靠', '厚度均匀，贴合紧密', '易模切，加工方便', '耐温耐候性能好', '多种粘性等级可选'],
    applications: ['海报固定粘贴', '地毯防滑固定', '工艺品拼接', '电子产品组装', '皮革箱包制作']
  },
  {
    id: 'meiwenzhi-jiaodai',
    name: '美纹纸胶带',
    category: '粘接材料',
    desc: '易撕不留痕，适用于喷漆遮蔽、墙面保护、办公等',
    spec: '耐温: 80-120℃',
    image: '/images/products/industrial-tape.jpg',
    detailDesc: '美纹纸胶带以美纹纸为基材，涂覆橡胶或丙烯酸压敏胶制成。具有易手撕、不残胶、耐高温、书写方便等特点。是喷漆遮蔽、临时标记、办公标注的理想选择。',
    features: ['手撕方便，无需工具', '撕除不残胶', '可书写标记', '耐高温，适合喷漆', '柔韧贴服性好'],
    applications: ['汽车喷漆遮蔽', '墙面分色保护', '临时标签标记', '美术绘画辅助', '装修施工保护']
  },
  {
    id: 'pp-dabaodai',
    name: 'PP打包带',
    category: '捆扎材料',
    desc: '韧性强、抗拉伸，适用于纸箱、货物捆扎打包',
    spec: '宽度: 9-19mm',
    image: '/images/products/pet-strapping.jpg',
    detailDesc: 'PP（聚丙烯）打包带以聚丙烯为原料，经挤出拉伸成型。具有韧性强、抗拉伸、比重轻、颜色鲜艳等特点。配合打包机使用，广泛应用于纸箱、货物、托盘等的捆扎固定。',
    features: ['韧性强，抗拉断', '比重轻，降低运输成本', '颜色多样可定制', '配合打包机使用效率高', '环保可回收'],
    applications: ['纸箱捆扎打包', '货物托盘固定', '物流运输包装', '仓储货物整理', '家电产品固定']
  },
  {
    id: 'pet-sugangdai',
    name: 'PET塑钢带',
    category: '捆扎材料',
    desc: '高强度打包带，替代钢带，环保耐用，适用于重货打包',
    spec: '拉伸强度: ≥250MPa',
    image: '/images/products/strapping.jpg',
    detailDesc: 'PET塑钢带（聚酯打包带）以聚对苯二甲酸乙二醇酯为原料，经挤出拉伸制成。具有强度高、韧性好、不锈蚀、环保等优点，是传统钢带的理想替代品，广泛应用于重型货物打包。',
    features: ['强度高，可替代钢带', '不生锈，保护货物', '韧性好，不断裂', '环保可回收', '使用安全，不伤手'],
    applications: ['重型机械打包', '建材石材固定', '棉花化纤打包', '金属制品捆扎', '大型托盘固定']
  },
  {
    id: 'chanraomo',
    name: '缠绕膜',
    category: '捆扎材料',
    desc: '拉伸缠绕膜，包装防潮防尘，适用于托盘包装',
    spec: '厚度: 15-50μm',
    image: '/images/products/stretch-film.jpg',
    detailDesc: '缠绕膜（ stretch film ）以LLDPE为主要原料，具有优异的拉伸性能和自粘性。包装后货物紧密缠绕，防潮防尘、防散落、防偷盗，是托盘包装和物流运输的必备材料。',
    features: ['高拉伸率，省膜', '自粘性强，无需胶带', '透明度高，识别方便', '防潮防尘防散落', '可手用或机用'],
    applications: ['托盘货物缠绕', '物流运输包装', '仓储货物防尘', '产品集合包装', '防偷盗保护']
  },
  {
    id: 'pe-baohumo',
    name: 'PE保护膜',
    category: '防护材料',
    desc: '表面防护专用膜，防止刮花、灰尘，适用于板材、型材',
    spec: '粘性: 低/中/高',
    image: '/images/products/pe-protective-film.jpg',
    detailDesc: 'PE保护膜以聚乙烯薄膜为基材，涂覆压敏胶制成。具有透明度高、粘性稳定、易撕除不残胶等特点。广泛应用于不锈钢板、铝板、塑料板、型材等产品的表面防护。',
    features: ['透明度高，不影响外观', '粘性稳定，不脱落', '撕除不残胶', '耐老化，保质期长', '低中高粘性可选'],
    applications: ['不锈钢板防护', '铝型材表面保护', '塑料板材贴膜', '玻璃表面防护', '电子产品屏幕保护']
  },
  {
    id: 'haimian-jiaotiao',
    name: '海绵胶条',
    category: '防护材料',
    desc: '高密度海绵，密封减震，适用于门窗、电子电器',
    spec: '规格: 可定制',
    image: '/images/products/sponge-seal-strip.jpg',
    detailDesc: '海绵胶条以EVA、CR、EPDM等海绵材料为基材，单面或双面涂覆压敏胶。具有优异的密封性、减震性、隔音性和耐候性。广泛应用于门窗密封、电子电器减震、汽车隔音等领域。',
    features: ['优异的密封防水性能', '良好的减震缓冲效果', '隔音降噪', '耐候耐老化', '规格形状可定制'],
    applications: ['门窗密封条', '电子电器减震', '汽车隔音降噪', '空调管道密封', '机械设备密封']
  },
  {
    id: 'qipao-mo',
    name: '气泡膜',
    category: '防护材料',
    desc: '缓冲气泡膜，防震防压，保护易碎物品',
    spec: '卷装/片装',
    image: '/images/products/bubble-wrap.jpg',
    detailDesc: '气泡膜以低密度聚乙烯为原料，经挤出成型制成含有无数独立气泡的薄膜。具有质轻、防震、防潮、隔音、抗压等优点。是电商物流、精密仪器、玻璃陶瓷等产品包装的首选缓冲材料。',
    features: ['气泡结构，缓冲防震', '质轻，降低运输成本', '防潮防水', '可定制气泡大小', '环保可回收'],
    applications: ['电商物流包装', '精密仪器防护', '玻璃陶瓷缓冲', '家具家电包装', '文件资料保护']
  },
  {
    id: 'fuhedai',
    name: '复合袋',
    category: '定制制袋',
    desc: '多层复合材料袋，防潮阻氧，适用于食品、药品包装',
    spec: '尺寸: 按需定制',
    image: '/images/products/composite-bag.jpg',
    detailDesc: '复合袋采用多层不同性能的薄膜材料复合而成，具有优异的阻隔性能。可根据产品需求组合PE、PET、AL、NY等材料，实现防潮、阻氧、避光、耐高温等功能，是食品、药品、化工产品包装的理想选择。',
    features: ['多层复合，阻隔性能优异', '防潮阻氧，保鲜保质', '耐高温，可蒸煮杀菌', '印刷精美，提升档次', '尺寸规格可定制'],
    applications: ['食品包装袋', '药品铝箔袋', '化工原料袋', '宠物食品袋', '调味品包装袋']
  },
  {
    id: 'zilidai',
    name: '自立袋',
    category: '定制制袋',
    desc: '底部可站立，自封口袋，便于陈列和使用',
    spec: '材质: PE/复合',
    image: '/images/products/stand-up-pouch.jpg',
    detailDesc: '自立袋底部有特殊结构设计，可使袋子站立不倒。配合自封拉链，开合方便，可重复使用。具有展示效果好、储存方便、密封性强等特点。广泛应用于零食、干果、调味品、宠物食品等包装。',
    features: ['底部站立设计，展示效果好', '自封拉链，可重复使用', '透明窗口，展示内容', '多种材质可选', '印刷精美，提升品牌'],
    applications: ['零食坚果包装', '干果蜜饯袋', '调味品包装袋', '宠物食品袋', '茶叶咖啡袋']
  },
  {
    id: 'fangjingdian-dai',
    name: '防静电袋',
    category: '定制制袋',
    desc: '防静电PE袋，保护电子元件免受静电损害',
    spec: '规格: 可定制',
    image: '/images/products/anti-static-bag.jpg',
    detailDesc: '防静电袋采用特殊配方的PE材料制成，表面电阻控制在10^6~10^11Ω之间，能有效防止静电积累和放电。适用于IC、PCB、电子元器件、精密仪器等对静电敏感产品的包装和运输。',
    features: ['防静电，保护敏感元件', '表面电阻稳定', '透明度高，识别方便', '无尘洁净，适合洁净室', '可印刷标识'],
    applications: ['IC芯片包装', 'PCB板防护', '电子元器件包装', '精密仪器防护', '硬盘存储包装']
  }
]

export function useProducts() {
  const config = useRuntimeConfig()

  return computed(() =>
    productDefinitions.map(product => ({
      ...product,
      image: resolvePublicAssetUrl(product.image, config.app.cdnURL)
    }))
  )
}

export function getProductById(id: string): Product | undefined {
  return productDefinitions.find(product => product.id === id)
}

export function getProductsByCategory(category: string): Product[] {
  if (category === '全部') return productDefinitions
  return productDefinitions.filter(product => product.category === category)
}

export const categories = ['全部', '缓冲材料', '粘接材料', '捆扎材料', '防护材料', '定制制袋']
