// import '.ignore/size_config.dart';

// const OurColors.scaffoldBackgroundColor = Color(0xFFF5F5F5); // Color(0xFFE5E5E5);
// const OurColors.main = Color(0xFF4CAF50);
// const OurColors.main = Color(0xFF56BA00);
/*
const kPrimaryLightColor = Color(0xFFEFEFEF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
*/

// const String RATE_FEEDBACK_MANDATORY = 'Напишите отзыв, чтобы мы могли принять меры';
const String RATE_FEEDBACK_MANDATORY =
    'Пожалуйста, опишите возникшую проблему и мы постараемся оперативно её решить.';

// const OurColors.lightGrey = Color(0xFF90969E); // Серый
// const OurColors.textColor = Color(0xFF242424); // Черный
// const OurColors.yellow = Color(0xFFFFED00);
const kTextAuthButton = "Войти";
const kAnimationDuration = Duration(milliseconds: 200);
// const kTextErrorPhoneNumberOutOfSystem = "Указанный номер телефона\n\nне зарегистрирован в системе «Топлайн»\n\nОбратитесь в службу технической\nподдержки (+7 3812) 300-009";
const List<String> dayWeek = [
  'ПН',
  'ВТ',
  'СР',
  'ЧТ',
  'ПТ',
  'СБ',
  'ВС',
];
const List<String> kMonthRus = [
  'январь',
  'февраль',
  'март',
  'апрель',
  'май',
  'июнь',
  'июль',
  'август',
  'сентябрь',
  'октябрь',
  'ноябрь',
  'декабрь'
];

const List<String> kMonthRusU = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь'
];

// final headingStyle = TextStyle(
//   fontSize: 28.sp,
//   fontWeight: FontWeight.bold,
//   color: Colors.black,
//   height: 1.5,
// );

// const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp phoneValidatorRegExp = RegExp(r'^\+?[\d\-\(\)]+$');
final RegExp emailValidatorRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
final RegExp passwordRegExp = RegExp(r'[\x21-\x7E]');
// final RegExp RusValidatorRegExp = RegExp(r'[\-\xA8\xB8\xC0-\xFF]'); // русские и "-"
final RegExp onlyCyrillicRegExp =
    RegExp(r'[\-\u0401\u0451\u0410-\u044f]'); // русские и "-"
// const String kPhoneNullError = "Введите Ваш номер телефона";
// const String kInvalidPhoneError = "Введите номер мобильного телефона";
// const String kInvalidEmailError = "Please Enter Valid Email";
// const String kEmailNullError = "Please Enter your email";
// const String kNameNullError = "Please Enter your name";
// const String kAddressNullError = "Please Enter your address";
// const String kPassNullERusValidatorRegExprror = "Введите Ваш пароль";
// const String kShortPassError = "Пароль слишком короткий";
// const String kMatchPassError = "Пароль слишком простой";

const String kNoInternet = "Проверьте ваше\nинтернет-соединение";
const String kTimeoutError = "Таймаут";
const String kTokenExpired = "Токен устарел";
const String kServerError = "Ошибка интернета"; // "Ошибка сервера"; // 500
const String kGooglePlayServicesMissing =
    "Сервисы Google Play не найдены. Функционал приложения будет ограничен!"; // "Ошибка сервера"; // 500
// const String mwKey = "55fab415-c078-4873-ab8d-64c56245ecae";

/*final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 8),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);*/

/*OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: OurColors.textColor),
  );
}*/
