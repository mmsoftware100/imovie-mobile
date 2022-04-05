final String appName = "zMovie";
//final String datshinBackendApiServer = 'https://imoviemm.com';
final String datshinBackendApiServer = 'https://moviesz.xyz/backend';
//final String datshinBackendApiServer = 'https://mmsoftware100.com/datshin/datshin-backend-api';
// https://mmsoftware100.com/datshin/datshin-backend-api/
final String apiHost = datshinBackendApiServer+'/api/v1/index.php?url=';
//final String apiHost = 'http://192.168.9.174/live/imovie/api/v1/index.php?url=';
final String apiEndpointCategory = apiHost+'movie/selectbycategory';
final String apiEndpointLatest = apiHost+'movie/select';
final String apiEndpointType = apiHost+'movie/selectbytype';
final String apiEndpointSearch = apiHost+'movie/selectbyname';
final String apiEndpointYear = apiHost+'movie/selectbyreleaseyear';
// http://localhost/live/imovie/api/v1/category/select
final String apiEndpointCategorySelect = apiHost+'category/select';
//final String apiEndpointCategorySelect = apiHost+'api/v1/category/select/index.php';
final String apiEndpointFileModelSelect = apiHost+'filelist/getlink';

final String apiEndpointUserLogin = apiHost+'user/login';

final String fullVideoAdsUrl = "https://miyabibonsai.s3-ap-northeast-1.amazonaws.com/uploads/sample.mp4";

const int streamCost = 25;
const int downloadCost = 100;
const int adsReward = 50;




