abstract class Config {

  static const hostName = 'http://api.themoviedb.org/3/';

  static const Map<String,String> endPoints = {
    'login' : 'v1/login',
    'signup' : 'v1/signup',
    'getuser' : 'v1/id/user/id'
  };

}
