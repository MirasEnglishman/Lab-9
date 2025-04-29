import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_9_1/auth/registration/bloc/registration_event.dart';
import 'package:lab_9_1/auth/registration/bloc/registration_state.dart';
import 'package:lab_9_1/auth/registration/repository/registration_repository.dart';
import 'package:lab_9_1/profile/pages/main_screen.dart';
import '../bloc/registration_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  late final RegistrationBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = RegistrationBloc(RegistrationRepository());
  }

  @override
  void dispose() {
    _bloc.close();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(RegistrationSubmitted(
        fullName: _nameCtrl.text,
        email: _emailCtrl.text,
        phone: _phoneCtrl.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Регистрация')),
        body: BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is RegistrationSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MainScreen()),
              );
            } else if (state is RegistrationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка: ${state.error}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(labelText: 'ФИО'),
                    validator: (v) => v!.isEmpty ? 'Введите ФИО' : null,
                  ),
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (v) => v!.contains('@') ? null : 'Неверный email',
                  ),
                  TextFormField(
                    controller: _phoneCtrl,
                    decoration: InputDecoration(labelText: 'Телефон'),
                    validator: (v) => v!.isEmpty ? 'Введите телефон' : null,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      if (state is RegistrationLoading) {
                        return CircularProgressIndicator();
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onSubmit,
                          child: Text('Зарегистрироваться'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
