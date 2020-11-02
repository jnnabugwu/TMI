import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tmi/models/constants.dart';
import 'package:tmi/models/social.dart';
import 'package:tmi/models/user.dart';
import 'package:tmi/respository/dataRepository.dart';

typedef DialogCallback = void Function();

class UserDetails extends StatelessWidget {

 
  const UserDetails(this.user);
  
  final User user;
  
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.name ?? ''),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        ),
        body: UserDetailForm(user),
      ),
    );
  }
}

class UserDetailForm extends StatefulWidget {
  
  const UserDetailForm(this.user);
  final User user;
  

  // const UserDetailForm({Key key, this.user}) : super(key: key);


  @override
  _UserDetailFormState createState() => _UserDetailFormState();

}

class _UserDetailFormState extends State<UserDetailForm> {
  final DataRepository repository = DataRepository();
  final _formKey = GlobalKey<FormBuilderState>();
  String name;
  String bio;

  @override 
  void initState(){

    super.initState();
  }

  @override 
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SingleChildScrollView(
              child: FormBuilder(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
            SizedBox(height: 20.0),
            FormBuilderTextField(
              attribute: 'bio',
              initialValue: widget.user.bio,
              decoration: textInputDecoration.copyWith(
                hintText: 'Bio', labelText: 'Bio'
              ),
              onChanged: (val){
                setState(() {
                  bio = val;
                });
              },
            ),
              FormBuilderCustomField(
                attribute: 'socials',
                formField: FormField(
                  enabled: true,
                  builder: (FormFieldState<dynamic> field) {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        Text(
                          'Socials',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16.0),
                      itemCount: widget.user.socials == null ? 0 : widget.user.socials.length, 
                      itemBuilder: (BuildContext context, int index) {
                      return buildRow(widget.user.socials[index]); 
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            FloatingActionButton(
              onPressed: (){
                _addSocial(widget.user ,(){
                  setState(() {   
                                   
                  });
                });
              },
              tooltip: 'Add Social',
              child: Icon(Icons.add),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  color: Colors.blue.shade600,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: 12.0), 
                  )),
                MaterialButton(
                  color: Colors.blue.shade600,
                  onPressed: () async {
                    if(_formKey.currentState.validate()){ 
                      await repository.updateUser(widget.user,'bio', bio);
                      Navigator.of(context).pop();                    
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize:12.0),
                  ),
                )
              ]
            )          
            ]
  )
  ),
      )
  );
  }

  Widget buildRow(Social social) {

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(social.app),
        ),
        Text(social.username),
      ],
    );
  }
  
  void _addSocial(User user, DialogCallback callback){
    String app;
    String username;
    final _formKey = GlobalKey<FormBuilderState>();
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('Socials'),
          content: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              autovalidate: true,
              child: Expanded(
                              child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: 'App',
                      validators: [
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.required()
                      ],
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Enter App Name',
                        labelText: 'Social'
                      ),
                      onChanged: (text){
                        setState(() {
                          app = text;
                        });
                      },
                    ),
                    ///change to a combobox later
                    FormBuilderTextField(
                    attribute: 'username',
                    validators: [
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.required()
                    ],
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Enter username',
                      labelText: 'Username'),
                    onChanged: (text){
                      setState(() {
                        username = text;
                      });
                    },
                    ),
                  ]
                ),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel')
            ),
            FlatButton(onPressed: (){
              if (_formKey.currentState.validate()){
                Navigator.of(context).pop();
                var newSocial = Social(app,
                 username: username);
                user.socials ??= <Social>[];
                user.socials.add(newSocial);
              }
              callback();
            }, child: Text('Add')),
          ],
        );  
      }
    );
  }

}