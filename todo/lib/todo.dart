import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/main.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class TaskData {
  int? id;
  String title;
  String description;
  String date;

  TaskData(
      {this.id,
      required this.title,
      required this.description,
      required this.date});

  Map<String, dynamic> taskMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
    };
  }

  @override
  String toString() {
    return '{id: $id, title: $title, description: $description, date: $date}';
  }
}

class User {
  String username;
  String password;

  User({required this.username, required this.password});
}

class _TodoState extends State<Todo> {
  List<TaskData> taskCard = dbList;
  List<User> userInfo = [
    User(username: "Aaditya", password: "login"),
  ];

  bool loginSuccessful = false;
  bool showPass = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void displayBottomSheet(bool isEditing, [TaskData? taskDataObj]) {
    if (!isEditing) {
      titleController.clear();
      descriptionController.clear();
      dateController.clear();
    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 13,
              ),
              Text(
                "Create To-Do",
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    autofocus: true,
                    controller: titleController,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      constraints: BoxConstraints(
                        maxHeight: 50,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    controller: descriptionController,
                    minLines: 1,
                    maxLines: 4,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: const InputDecoration(
                      constraints: BoxConstraints(
                        minHeight: 60,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Date",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(89, 57, 241, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    keyboardType: TextInputType.none,
                    onTap: selectDate,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: selectDate,
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromRGBO(89, 57, 241, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 330,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    submit(isEditing, taskDataObj);
                    Navigator.of(context).pop();
                  },
                  style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    // backgroundColor: MaterialStatePropertyAll(
                    //   Color.fromRGBO(89, 57, 241, 1),
                    // ),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        );
      },
    );
  }

  void selectDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    String formatedDate = DateFormat.yMMMd().format(pickDate!);
    setState(() {
      dateController.text = formatedDate;
    });
  }

  void submit(bool isEditing, [TaskData? taskDataObj]) async {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (isEditing) {
        taskDataObj!.title = titleController.text.trim();
        taskDataObj.description = descriptionController.text.trim();
        taskDataObj.date = dateController.text.trim();
        await updateTask(taskDataObj);
      } else {
        await insertTask(
          TaskData(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            date: dateController.text.trim(),
          ),
        );
        dbList = await getTasksData();
        // taskCard.add(
        //   TaskData(
        //     title: titleController.text.trim(),
        //     description: descriptionController.text.trim(),
        //     date: dateController.text.trim(),
        //   ),
        // );
      }
    }
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    setState(() {
      taskCard = dbList;
    });
  }

  void editCard(TaskData taskDataObj) {
    titleController.text = taskDataObj.title;
    descriptionController.text = taskDataObj.description;
    dateController.text = taskDataObj.date;

    displayBottomSheet(true, taskDataObj);
  }

  @override
  Widget build(BuildContext context) {
    if (!loginSuccessful) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 70,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    "Login to get started",
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Username",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: usernameController,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      // constraints: BoxConstraints(
                      //   maxHeight: 50,
                      // ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Username",
                      prefixIcon: const Icon(
                        Icons.person_outline_sharp,
                        size: 27,
                        color: Colors.black45,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter username";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: passwordController,
                    textAlignVertical: TextAlignVertical.top,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      // constraints: BoxConstraints(
                      //   maxHeight: 50,
                      // ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Password",
                      suffixIcon: showPass
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              child: const Icon(
                                Icons.visibility_outlined,
                                size: 25,
                                color: Colors.black45,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              child: const Icon(
                                Icons.visibility_off_outlined,
                                size: 25,
                                color: Colors.black45,
                              ),
                            ),
                      prefixIcon: const Icon(
                        Icons.lock_outline_sharp,
                        size: 27,
                        color: Colors.black45,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(210, 238, 238, 238),
                        ),
                      ),
                    ),
                    obscureText: !showPass,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      _formKey.currentState!.validate();
                      for (var i = 0; i < userInfo.length; i++) {
                        if (userInfo[i].username == usernameController.text &&
                            userInfo[i].password == passwordController.text) {
                          setState(() {
                            loginSuccessful = _formKey.currentState!.validate();
                          });
                        }
                      }
                      if (loginSuccessful) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Welcome ${usernameController.text}"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // setState(() {});
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter valid username or password"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(111, 81, 255, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: GoogleFonts.quicksand(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          color: const Color.fromRGBO(111, 81, 255, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 29, top: 85),
                child: Text(
                  "Good Morning",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 29, bottom: 41),
                child: Text(
                  "Aaditya",
                  style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 19, bottom: 18),
                        child: Text(
                          "CREATE TO DO LIST",
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 39,
                                ),
                                SizedBox(
                                  height: 597,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    itemCount: taskCard.length,
                                    itemBuilder: (context, index) {
                                      return Slidable(
                                        closeOnScroll: true,
                                        endActionPane: ActionPane(
                                          extentRatio: 0.2,
                                          closeThreshold: 0.5,
                                          motion: const DrawerMotion(),
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      editCard(taskCard[index]);
                                                    },
                                                    child: Container(
                                                      height: 31.92,
                                                      width: 31.92,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            89, 57, 241, 1),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons.edit_outlined,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      deleteTask(
                                                          taskCard[index]);
                                                      dbList =
                                                          await getTasksData();
                                                      taskCard = dbList;
                                                      setState(() {
                                                        // taskCard.remove(
                                                        //     taskCard[index]);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 31.92,
                                                      width: 31.92,
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color.fromRGBO(
                                                            89, 57, 241, 1),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    0,
                                                                    0,
                                                                    0.1),
                                                          ),
                                                        ],
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .delete_outline_outlined,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 5,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.08),
                                                offset: Offset(0, 4),
                                                blurRadius: 20,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 55,
                                                width: 55,
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal: 25,
                                                ),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      217, 217, 217, 1),
                                                ),
                                                child: Image.asset(
                                                  "assets/images/onerror.png",
                                                  width: 26.79,
                                                  height: 22.07,
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: 245,
                                                    height: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        taskCard[index].title,
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          textStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0, 0, 0, 1),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: 245,
                                                    height: 30,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Text(
                                                        taskCard[index]
                                                            .description,
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          textStyle:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    84,
                                                                    84,
                                                                    84,
                                                                    1),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: 245,
                                                    height: 15,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Text(
                                                      taskCard[index].date,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Color.fromRGBO(
                                                              84, 84, 84, 1),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              0, 0, 0, 0.5),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            displayBottomSheet(false);
          },
          shape: const CircleBorder(eccentricity: 0),
          child: const Icon(
            Icons.add_sharp,
            size: 50,
            color: Colors.white,
            shadows: [
              BoxShadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ],
          ),
        ),
      );
    }
  }
}
