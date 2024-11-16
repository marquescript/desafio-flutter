import "package:flutter_test/flutter_test.dart";
import "package:login_app/core/constants/login_error.dart";
import "package:login_app/service/login_service.dart";

void main(){

  late LoginService loginService;

  setUp(() {
    loginService = LoginService();
  });

  test("Login service validatePassword must pass successfully", (){
    String validated = loginService.validatePassword("C@rlos12345");
    expect(validated, "");
  });

  test("Login service validatePassword should fail with a password shorter than 8 characters", (){
    String validated = loginService.validatePassword("passwor");
    expect(validated, isNotEmpty);
    expect(validated, equals(LoginError.invalidCharacterQuantity));
  });

  test("Login service validatePassword should fail with a password that does not have a number", (){
    String validated = loginService.validatePassword("P@ssword");
    expect(validated, isNotEmpty);
    expect(validated, equals(LoginError.numberIsRequired));
  });

  test("Login service validatePassword should fail with a password that does not have an uppercase character", (){
    String validated = loginService.validatePassword("p@ssword1");
    expect(validated, isNotEmpty);
    expect(validated, equals(LoginError.uppercaseCharacterIsRequired));
  });

  test("Login service validatePassword should fail with a password that does not have a lowercase character", (){
    String validated = loginService.validatePassword("P@SSWORD1");
    expect(validated, isNotEmpty);
    expect(validated, equals(LoginError.lowercaseCharacterIsRequired));
  });

  test("Login service validatePassword should fail with a password that does not have a special character", (){
    String validated = loginService.validatePassword("Password12");
    expect(validated, isNotEmpty);
    expect(validated, equals(LoginError.specialCharacterIsRequired));
  });

}