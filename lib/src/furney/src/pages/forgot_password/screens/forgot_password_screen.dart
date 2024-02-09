part of '../forgot_password_page.dart';

class FurneyForgotPasswordScreen extends StatefulWidget { 
  const FurneyForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _FurneyForgotPasswordScreenState createState() => _FurneyForgotPasswordScreenState();
}

class _FurneyForgotPasswordScreenState extends State<FurneyForgotPasswordScreen> {
  TextEditingController? _emailController;
  final bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: Const.margin),
          children: [
            _HeaderSection(),
            const SizedBox(height: Const.space25),
            const _BodySection(),
            const SizedBox(height: Const.space25),

          ],
        ),
      ),
    );
  }
}
