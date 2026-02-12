// import 'package:flutter/material.dart';
// import 'dart:async';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Responsive Login App',
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: const Color(0xFF161F1C),
//         colorScheme: const ColorScheme.dark(
//           primary: Color(0xFF161F1C),
//           onPrimary: Colors.white,
//           secondary: Colors.green,
//           onSecondary: Colors.white,
//         ),
//         textButtonTheme: TextButtonThemeData(
//           style: TextButton.styleFrom(
//             foregroundColor: Colors.white,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//           ),
//         ),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(seconds: 1),
//       () => Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (BuildContext context) => OnboardingScreen(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFF161F1C),
//       child: Center(
//         child: Image.asset('assets/img/logo1.jpg',
//             scale: MediaQuery.of(context).size.width / 600),
//       ),
//     );
//   }
// }

// class OnboardingScreen extends StatelessWidget {
//   final PageController _pageController = PageController();

//   OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       controller: _pageController,
//       children: [
//         OnboardingPage(
//           imageUrl: 'assets/img/1.jpg',
//           title: 'Best Package Delivery Just for You',
//           subtitle:
//               'It is a long-established fact that a reader will be distracted by the readable content.',
//           buttonLabel: 'Next',
//           onNextPressed: () => _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeIn),
//         ),
//         OnboardingPage(
//           imageUrl: 'assets/img/2.jpg',
//           title: 'Track Your Order From Anywhere',
//           subtitle:
//               'It is a long-established fact that a reader will be distracted by the readable content.',
//           buttonLabel: 'Next',
//           onNextPressed: () => _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeIn),
//         ),
//         OnboardingPage(
//           imageUrl: 'assets/img/3.jpg',
//           title: 'Get Your Order Safely On Time',
//           subtitle:
//               'It is a long-established fact that a reader will be distracted by the readable content.',
//           buttonLabel: 'Get Started',
//           onNextPressed: () {
//             String name = ''; // Logic to retrieve user's name
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (_) => LoginScreen(userName: name)));
//           },
//         ),
//       ],
//     );
//   }
// }

// class OnboardingPage extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String subtitle;
//   final String buttonLabel;
//   final VoidCallback onNextPressed;

//   const OnboardingPage({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.subtitle,
//     required this.buttonLabel,
//     required this.onNextPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF161F1C),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(imageUrl, scale: MediaQuery.of(context).size.width / 800),
//           const SizedBox(height: 20),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 25 * MediaQuery.of(context).textScaleFactor,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 5),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: 18 * MediaQuery.of(context).textScaleFactor,
//               color: Colors.grey[350],
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: ElevatedButton(
//               onPressed: onNextPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF007C4F),
//                 foregroundColor: Colors.white,
//                 minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
//               ),
//               child: Text(buttonLabel),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   final String userName;

//   LoginScreen({super.key, required this.userName});

//   final TextEditingController emailcontroller = TextEditingController();
//   final TextEditingController passwordcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: <Widget>[
//             const SizedBox(height: 60),
//             Image.asset('assets/img/logo1.jpg',
//                 height: 120), // Make sure the asset path is correct
//             const SizedBox(height: 20),
//             const Text(
//               "Let's get your login!",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const Text(
//               "Enter your information below",
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 40),
//             TextField(
//               controller: emailcontroller,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: 'Enter Email',
//                 border: const OutlineInputBorder(),
//                 prefixIcon: const Icon(Icons.email),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.green),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: passwordcontroller,
//               keyboardType: TextInputType.visiblePassword,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Enter Password',
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//                 border: const OutlineInputBorder(),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.green),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ForgetPasswordScreen()),
//                   );
//                 },
//                 style: ButtonStyle(
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(const Color(0xFF00C27C)),
//                 ),
//                 child: const Text('Forget Password?'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String email = emailcontroller.text;
//                 String password = passwordcontroller.text;
//                 if (password.isEmpty || email.isEmpty) {
//                   // Check if email or password is empty
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text("Error"),
//                         content:
//                             const Text("Email and Password cannot be empty."),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("Close"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
//                     .hasMatch(email)) {
//                   // Check if email is in valid format
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text("Error"),
//                         content: const Text("Please enter a valid email."),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("Close"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else {
//                   // Validation successful, proceed with login
//                   print("Email: $email");
//                   print("Password: $password");
//                 }
//               },
//               child: const Text('Login'),
//             ),
//             const SizedBox(height: 20),
//             const Row(
//               children: <Widget>[
//                 Expanded(child: Divider(color: Colors.grey)),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Or login with'),
//                 ),
//                 Expanded(child: Divider(color: Colors.grey)),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _socialButton(context, Icons.g_translate, 'Google',
//                     const Color(0xFF4285F4)),
//                 const SizedBox(width: 16),
//                 _socialButton(context, Icons.facebook, 'Facebook',
//                     const Color(0xFF4267B2))
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Not our Member Yet?"),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => RegistrationScreen()),
//                     );
//                   },
//                   style: ButtonStyle(
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                         const Color(0xFF00C27C)),
//                   ),
//                   child: const Text('Register Now'),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _socialButton(
//       BuildContext context, IconData icon, String label, Color bgColor) {
//     return ElevatedButton.icon(
//       onPressed: () {
//         // TODO: Implement Social Login logic
//       },
//       icon: Icon(icon),
//       label: Text(label),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all<Color>(bgColor),
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//         minimumSize: MaterialStateProperty.all<Size>(const Size(140, 50)),
//       ),
//     );
//   }
// }

// class RegistrationScreen extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   RegistrationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF161F1C),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             Image.asset('assets/img/logo1.jpg',
//                 height: 120), // Make sure the asset path is correct
//             const SizedBox(height: 40),
//             const Text(
//               'Register Your New Account!',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Enter your information Below',
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//             const SizedBox(height: 32),
//             _buildTextField(nameController, 'Name', Icons.person),
//             const SizedBox(height: 16),
//             _buildTextField(emailController, 'Email', Icons.email),
//             const SizedBox(height: 16),
//             _buildTextField(phoneController, 'Phone', Icons.phone),
//             const SizedBox(height: 16),
//             _buildTextField(countryController, 'Country', Icons.flag),
//             const SizedBox(height: 16),
//             _buildTextField(cityController, 'City', Icons.location_city),
//             const SizedBox(height: 16),
//             _buildTextField(addressController, 'Address', Icons.home),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 String name = nameController.text.trim();
//                 String email = emailController.text.trim();
//                 String phone = phoneController.text.trim();
//                 String country = countryController.text.trim();
//                 String city = cityController.text.trim();
//                 String address = addressController.text.trim();

//                 if (name.isEmpty ||
//                     email.isEmpty ||
//                     phone.isEmpty ||
//                     country.isEmpty ||
//                     city.isEmpty ||
//                     address.isEmpty) {
//                   _showDialog(context, 'Error', 'All fields are required.');
//                 } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
//                   _showDialog(context, 'Error', 'Please enter a valid name.');
//                 } else if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$')
//                     .hasMatch(email)) {
//                   _showDialog(context, 'Error', 'Please enter a valid email.');
//                 } else if (!RegExp(r'^01[0-9]{9}$').hasMatch(phone)) {
//                   _showDialog(context, 'Error',
//                       'Please enter a valid phone number starting with 01 and with 11 digits.');
//                 } else {
//                   // Validation successful, proceed with registration
//                   print("Name: $name");
//                   print("Email: $email");
//                   print("Phone: $phone");
//                   print("Country: $country");
//                   print("City: $city");
//                   print("Address: $address");
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green, // Button background color
//                 foregroundColor: Colors.white, // Button text color
//                 minimumSize:
//                     const Size(double.infinity, 50), // Button width and height
//               ),
//               child: const Text('Register'),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Already a member ?',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Login',
//                       style: TextStyle(color: Colors.green)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       TextEditingController controller, String label, IconData icon) {
//     return TextFormField(
//       controller: controller,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.grey),
//         prefixIcon: Icon(icon, color: Colors.green),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.white),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.green),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//     );
//   }

//   void _showDialog(BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class ForgetPasswordScreen extends StatelessWidget {
//   final TextEditingController phoneController = TextEditingController(text: '');
//   final TextEditingController emailController = TextEditingController(text: '');

//   ForgetPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF161F1C),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             const Text(
//               'Forget Password',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             const Text(
//               'Select which contact details should be used to reset your password',
//               style: TextStyle(color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 40),
//             ListTile(
//               // leading: Icon(Icons.phone, color: Colors.green),
//               title: TextField(
//                 controller: phoneController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Send OTP Via SMS',
//                   labelStyle: const TextStyle(color: Colors.grey),
//                   prefixIcon: const Icon(Icons.phone, color: Colors.green),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.green),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               // leading: Icon(Icons.email, color: Colors.green),
//               title: TextField(
//                 controller: emailController,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Send OTP Via Email',
//                   labelStyle: const TextStyle(color: Colors.grey),
//                   prefixIcon: const Icon(Icons.email, color: Colors.green),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.white),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.green),
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 // TODO: Implement continue action
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text('Continue'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
