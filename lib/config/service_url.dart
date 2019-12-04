const serviceUrl = 'http://v.jspang.com:8088/baixing/';//此处为异步接口配置
const servicePath = { //设置异步请求路径
  'homePageContext': serviceUrl + 'wxmini/homePageContent', //商店首页信息
  'homePageBelowConten': serviceUrl + 'wxmini/homePageBelowConten', //商店首页热卖商品
  'getCategory': serviceUrl + 'wxmini/getCategory', //商品类别
  'getMallGoods': serviceUrl+'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById': serviceUrl+'wxmini/getGoodDetailById', //商品详情
};