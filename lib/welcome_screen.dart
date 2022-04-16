import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'dart:io';
import 'package:camera/camera.dart';

class WelcomeScreen extends StatelessWidget {

  static const routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1557683316-973673baf926?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&w=1000&q=80'),
                  fit: BoxFit.fill),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Column(
                    children: const [
                      Text('Hello', style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, color: Colors.white),),
                      Text('My Scanner App', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),),
                    ],
                  ),
                ),),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: RaisedButton(
                        onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.indigo,
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 25, left: 24, right: 24),
                      child: RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.white,
                        onPressed: () => Navigator.of(context).pushNamed(SignupScreen.routeName),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for caputred image

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if(cameras != null){
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    }else{
      print("NO any camera found");
    }
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text("Live Camera Preview"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          child: Column(
              children:[
                Container(
                    height:300,
                    width:400,
                    child: controller == null?
                    Center(child:Text("Loading Camera...")):
                    !controller!.value.isInitialized?
                    const Center(
                      child: CircularProgressIndicator(),
                    ):
                    CameraPreview(controller!)
                ),



                Container( //show captured image
                  padding: EdgeInsets.all(30),
                  child: image == null?
                  Text("No image captured"):
                  Image.file(File(image!.path), height: 300,),
                  //display captured image
                )
              ]
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          try {
            if(controller != null){ //check if contrller is not null
              if(controller!.value.isInitialized){ //check if controller is initialized
                image = await controller!.takePicture(); //capture image
                setState(() {
                });
              }
            }
          } catch (e) {
            print(e); //show error
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
