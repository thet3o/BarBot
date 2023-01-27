class AuthResponse{
  final String accessToken;
  final String tokenType;

  const AuthResponse({required this.accessToken, required this.tokenType});

  factory AuthResponse.fromJson(Map<String, dynamic> json){
    return AuthResponse(accessToken: json['access_token'], tokenType: json['token_type']);
  }
}