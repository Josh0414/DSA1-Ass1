import ballerina/http;
import ballerina/io;

http:Client programmeClient = check new ("http://localhost:8080/programmes");

type Course record {
    string courseName;
    string courseCode;
    int nqfLevel;
};

type Programme record {
    readonly string programmeCode;
    int nqfLevel;
    string faculty;
    string department;
    string title;
    string registrationDate;
    string status;
    Course[] courses?;
};

public function main() returns error? {
    
    io:println("1. Add Programme");
    io:println("2. Retrieve All Programmes");
    io:println("3. Update Programme");
    io:println("4. Retrieve Programme By Code");
    io:println("5. Delete Programme");
    io:println("6. Retrieve Programmes Due For Review");
    io:println("7. Retrieve Programmes By Faculty");
    io:println("Select an option (1-7):");

    string option = io:readln();
    if option == "1" {
        _ = check addProgramme();
    }

    if option == "2" {
        _ = check retrieveAllProgrammes();
    }

    if option == "3" {
        _ = check updateProgramme();
    }

    if option == "4" {
        _ = check retrieveProgrammeByCode();
    }

    if option == "5" {
        _ = check deleteProgramme();
    }

    if option == "6" {
        _ = check retrieveProgrammesDueForReview();
    }

    if option == "7" {
        _ = check retrieveProgrammesByFaculty();
    }
}

function addProgramme() returns error? {
    Programme newProgramme = check createProgramme();
    Programme response = check programmeClient->/addProgramme.post(newProgramme);
    io:println(response);
}

function retrieveAllProgrammes() returns error? {
    Programme[] response = check programmeClient->/allProgrammes.get();
    io:println(response);
}

function updateProgramme() returns error? {
    io:println("Enter programme code to update:");
    string code = io:readln();
    Programme response = check programmeClient->/programmeByCode/[code];
    string title = io:readln(string `Enter title (Current ${response.title})`);
    string nqfLevel = io:readln(string `Enter title (Current ${response.nqfLevel})`);
    string faculty = io:readln(string `Enter title (Current ${response.faculty})`);
    string department = io:readln(string `Enter title (Current ${response.department})`);
    string registrationDate = io:readln(string `Enter title (Current ${response.registrationDate})`);
    string status = io:readln(string `Enter title (Current ${response.status})`);

    Programme update = {
        registrationDate: registrationDate != "" ? registrationDate : response.registrationDate,
        department: department != "" ? department : response.department,
        title: title != "" ? title : response.title,
        programmeCode: response.programmeCode,
        nqfLevel: nqfLevel != "" ? check int:fromString(nqfLevel) : response.nqfLevel,
        faculty: faculty != "" ? faculty : response.faculty,
        status: status != "" ? status : response.status,
        courses: []
    };
    Programme result = check programmeClient->/updateProgramme.put(update);
    io:println(result);
}

function retrieveProgrammeByCode() returns error? {
    io:println("Enter programme code to update:");
    string code = io:readln();
    Programme response = check programmeClient->/programmeByCode/[code];
    io:println(response);
}

function deleteProgramme() returns error? {
    io:println("Enter programme code to delete:");
    string code = io:readln();
    error? response = programmeClient->/deleteProgramme/[code].delete();
    io:println(response);
}

function retrieveProgrammesDueForReview() returns error? {
    Programme[] response = check programmeClient->/programmesDueForReview.get();
    io:println(response);
}

function retrieveProgrammesByFaculty() returns error? {
    io:println("Enter faculty name:");
    string faculty = io:readln();
    Programme[] response = check programmeClient->/programmesByFaculty/[faculty]();
    io:println(response);
}


function createProgramme() returns Programme|error {
    io:println("Enter programme code:");
    string code = io:readln();
    io:println("Enter NQF level:");
    int nqfLevel = check int:fromString(io:readln());
    io:println("Enter faculty name:");
    string faculty = io:readln();
    io:println("Enter department name:");
    string department = io:readln();
    io:println("Enter programme title:");
    string title = io:readln();
    io:println("Enter registration date (YYYY-MM-DD):");
    string registrationDate = io:readln();

    Course[] courses = []; // In real implementation, prompt user to add courses

    string keepAddingCourses = "yes";
    while keepAddingCourses.equalsIgnoreCaseAscii("yes") {
        string courseName = io:readln("Enter course name: ");
        string courseCode = io:readln("Enter course code: ");
        string coursenqfLevel = io:readln("Enter course nql level (1 - 10): ");

        Course coursetosave = {courseCode: courseCode, courseName: courseName, nqfLevel: check int:fromString(coursenqfLevel)};
        courses.push(coursetosave);
        keepAddingCourses = io:readln("Continue (yes/no): ");
    }
    return {
        programmeCode: code,
        nqfLevel: nqfLevel,
        faculty: faculty,
        department: department,
        title: title,
        registrationDate: registrationDate,
        courses: courses,
        status: "review"
    };
}
