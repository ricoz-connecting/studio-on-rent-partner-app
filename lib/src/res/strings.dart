class AppUrls {
  static const baseUrl = "https://e620-103-24-84-14.ngrok-free.app";
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
  static const requestEndPoint = '/api/agent/request';
  static const loginOtpEndPoint = '/api/agent/otp/login';
  static const payment = '/api/agent/payment';
  static const filter = '/api/agent/filter';
  static const update = '/api/agent/update';
  static const favourites = '/api/agent/favourites';
  static const delete = '/api/agent/delete';
  static const help = '/api/agent/help';
  // AGENT
  static const studioRequestEndPoint = '/api/agent/studio';
  static const registerEndpoint = '/api/agent/register';
  static const isVerified = '/api/agent/verification';
  static const schedulesUpdateEndPoint = "/api/agent/schedulesUpdate";
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
