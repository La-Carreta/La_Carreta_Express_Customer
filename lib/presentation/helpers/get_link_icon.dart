import 'dart:math';

final urlIcons = [
  'https://res.cloudinary.com/dwexseytn/image/upload/v1703721212/La_Carreta_Express/Various_icons/pizza_ccg0lb.png',
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703721461/La_Carreta_Express/Various_icons/bol-de-arroz_mua8dn.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703721642/La_Carreta_Express/Various_icons/chinese-food_myv7cr.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703721700/La_Carreta_Express/Various_icons/chinese-food_d2jog1.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703721812/La_Carreta_Express/Various_icons/pizza_eil9gm.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722133/La_Carreta_Express/Various_icons/pez_epgzc9.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722167/La_Carreta_Express/Various_icons/pescado-frito_t9swed.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722196/La_Carreta_Express/Various_icons/ceviche_bmoylv.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722229/La_Carreta_Express/Various_icons/ceviches_e0lb6u.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722257/La_Carreta_Express/Various_icons/ceviche_1_pog6oh.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722390/La_Carreta_Express/Various_icons/ceviche_2_rqxucp.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722448/La_Carreta_Express/Various_icons/ceviches_1_delxnm.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722487/La_Carreta_Express/Various_icons/paella_au9nbh.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722520/La_Carreta_Express/Various_icons/mariscos_gpi2qn.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722567/La_Carreta_Express/Various_icons/pez_1_x3s5fm.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722611/La_Carreta_Express/Various_icons/mariscos_1_vydvaj.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722687/La_Carreta_Express/Various_icons/hamburguesa-con-queso_lwsnmm.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722715/La_Carreta_Express/Various_icons/hamburguesa_hxpeop.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722740/La_Carreta_Express/Various_icons/hamburguesa_1_nlad5f.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722798/La_Carreta_Express/Various_icons/pierna-de-pollo_ww3dcc.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722827/La_Carreta_Express/Various_icons/pollo_wc3rcg.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703722880/La_Carreta_Express/Various_icons/carne_pqck25.png"
];

final urlIconsNotificaciones = [
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703805014/La_Carreta_Express/Various_icons/order_1_mzglvm.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703805014/La_Carreta_Express/Various_icons/order_inopx7.png",
  "https://res.cloudinary.com/dwexseytn/image/upload/v1703805014/La_Carreta_Express/Various_icons/order_2_v6vn2g.png"
];

String getUrlIconPlatos() {
  Random random = Random();
  int numAleatorio = random.nextInt(urlIcons.length);
  return urlIcons[numAleatorio];
}

String getUrlIconNotificaciones() {
  Random random = Random();
  int numAleatorio = random.nextInt(urlIconsNotificaciones.length);
  return urlIconsNotificaciones[numAleatorio];
}
