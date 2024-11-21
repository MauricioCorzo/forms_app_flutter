import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/infrastructure/inputs/email.dart';
import 'package:forms_app/infrastructure/inputs/password.dart';
import 'package:forms_app/infrastructure/inputs/username.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/inputs/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New user registration'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: _RegisterView(),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  _RegisterView();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 350,
                child: Image.network(
                  "https://banner2.cleanpng.com/20180329/zue/kisspng-computer-icons-user-profile-person-5abd85306ff7f7.0592226715223698404586.jpg",
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "¡Welcome!",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    BlocSelector<RegisterCubit, RegisterFormState,
                        UsernameInput>(
                      selector: (state) {
                        return state.username;
                      },
                      builder: (context, username) {
                        return CustomTextFormField(
                          label: "Name",
                          hintText: 'Your first name',
                          filled: true,
                          errorText: username.errorMessage,
                          // errorText: username.isPure || username.isValid
                          //     ? null
                          //     : switch (username.error) {
                          //         UsernameInputError.empty =>
                          //           "Please enter your name",
                          //         UsernameInputError.length =>
                          //           "Name must be at least 6 characters long",
                          //         UsernameInputError.witheSpace =>
                          //           'Name cannot start or end with a space',
                          //         null => null,
                          //       },
                          onChanged: (value) {
                            // Save it
                            context
                                .read<RegisterCubit>()
                                .usernameChanged(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    BlocSelector<RegisterCubit, RegisterFormState, EmailInput>(
                      selector: (state) {
                        return state.email;
                      },
                      builder: (context, state) {
                        return CustomTextFormField(
                          label: 'Email',
                          hintText: 'email@gmail.com',
                          filled: true,
                          errorText: state.errorMessage,
                          onChanged: (value) {
                            // Save it
                            context.read<RegisterCubit>().emailChanged(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    BlocSelector<RegisterCubit, RegisterFormState,
                        PasswordInput>(
                      selector: (state) {
                        return state.password;
                      },
                      builder: (context, state) {
                        return CustomTextFormField(
                          label: 'Password',
                          hintText: '********',
                          filled: true,
                          obscurteText: true,
                          errorText: state.errorMessage,
                          onChanged: (value) {
                            // Save it
                            context
                                .read<RegisterCubit>()
                                .passwordChanged(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   // Navigate to the main screen
                        // }
                        context.read<RegisterCubit>().onSubmitted();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF00BF6D),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Create user"),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text.rich(
                        const TextSpan(
                          text: "Don’t have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(color: Color(0xFF00BF6D)),
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.64),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
