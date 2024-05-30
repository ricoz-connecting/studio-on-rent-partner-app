class AppUrls {
  static const baseUrl = "https://booking-studio-node-apis.vercel.app";
  static const otpEndPoint = '/api/otp';
  static const categoryEndpoint = '/api/agent/category';
  static const locationEndPoint = '/api/agent/city';
  static const loginEndPoint = '/api/agent/login';
  static const signupEndPoint = '/api/agent/signup';
  static const homeViewEndPoint = '/api/agent/homeview';
  static const descriptionEndpoint = '/api/agent/description';
  static const reviewEndPoint = '/api/agent/review';
  static const search = '/api/agent/search';
  static const chat = '/api/agent/chat';
  static const agent = '/api/agent/agent';
  static const earningRequestEndPoint = "/api/agent/earning";
  static const requestEndPoint = '/api/agent/request';
  static const loginOtpEndPoint = '/api/agent/otp/login';
  static const filter = '/api/agent/filter';
  static const update = '/api/agent/update';
  static const favourites = '/api/agent/favourites';
  static const delete = '/api/agent/delete';
  static const help = '/api/help';
  // AGENT
  static const studioRequestEndPoint = '/api/agent/studio';
  static const registerEndpoint = '/api/agent/register';
  static const isVerified = '/api/agent/verification';
  static const schedulesUpdateEndPoint = "/api/agent/schedulesUpdate";
  static const bankDetailsEndPoint = '/api/agent/bank/get';
  static const addBankDetailsEndPoint = '/api/agent/bank/add';
  static const withdrawEndPoint = '/api/agent/withdraw';
  static const issuesEndPoint = '/api/agent/issues';
}

class AppFailures {
  static const String apiFailure = "API EXCEPTION PLEASE TRY AGAIN";
}

class ScheduleStatus {
  static const accepted = "accepted";
  static const pending = "pending";
  static const delivered = "delivered";
  static const rejected = "rejected";
}
