import 'package:dexiheri/app/sign_in/validators.dart';
import 'package:dexiheri/common_widgets/form_submit_button.dart';
import 'package:dexiheri/common_widgets/show_alert_dialog.dart';
import 'package:dexiheri/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(
          context,
          title: 'Αποτυχία Σύνδεσης',
          content: e.toString(),
          defaultActionText: 'OK');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText =
        _formType == EmailSignInFormType.signIn ? 'Σύνδεση' : 'Εγγραφή';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Δεν έχετε λογαριασμό; Εγγραφείτε'
        : 'Είστε ήδη εγγεγραμένος; Συνδεθείτε';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;
    return [
      //e-mail textfield
      _buildEmailTextField(),
      //password textfield
      _buildPasswordTextField(),
      Divider(height: 6.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      //Sign up / Sign In toggler
      TextButton(
        onPressed:  _toggleFormType,
        child: Text(secondaryText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Εισαγωγή password...',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white, fontSize: 17),
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      obscureText: true,
      onChanged: (password) => _updateState(),
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: 'Εισαγωγή email...',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white, fontSize: 17),
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      autocorrect: false,
      onChanged: (email) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    print('email: $_email , password: $_password');
    setState(() {});
  }
}
