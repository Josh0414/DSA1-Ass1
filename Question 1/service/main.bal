


import ballerina/http;



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
    Course[] courses;
};

table<Programme> key(programmeCode) programmes =  table[
 {courses: [
    {courseName: "Distributed Systems", courseCode: "DSA611S", nqfLevel: 8}
 ], registrationDate: "2024-09-09", department: "Cyber Security", title: "Bachelor of Cyber Security", programmeCode: "BOCS", nqfLevel: 7, faculty: "FCI", status: "review"}
];


service /programmes on new http:Listener(8080) {

    // In-memory storage for programmes
    map<Programme> programmes = {};

    // Add a new programme
    resource function post addProgramme(Programme payload) returns Programme|error{
        Programme newProgramme = payload;
        if (programmes.hasKey(newProgramme.programmeCode)) {
            return error("Programme with this code already exists.");
        }
        programmes.add(newProgramme);
        return newProgramme;
    }

    // Retrieve all programmes
    resource function get allProgrammes() returns Programme[]|error {
        return programmes.toArray();
    }

    // Update an existing programme
    resource function put updateProgramme(Programme programme) returns Programme|error {
        string programmeCode = programme.programmeCode;
        if (!programmes.hasKey(programmeCode)) {
            return error("Programme not found.");
        }
        programmes.put(programme);
        return programmes.get(programmeCode);
    }

    // Retrieve a specific programme
    resource function get programmeByCode/[string programmeCode]() returns Programme|error {
        return programmes.get(programmeCode);
    }

    // Delete a programme
    resource function delete deleteProgramme/[string programmeCode]() returns error? {
        if programmes.hasKey(programmeCode) {
            return error("Programme does not exist");
        }else {
            _ = programmes.remove(programmeCode);
        }
    }

    // Retrieve all programmes due for review
    resource function get programmesDueForReview() returns error|Programme[] {
        Programme[] programmesForReview = [];
        foreach var item in programmes {
            if item.status == "review" {
                programmesForReview.push(item);
            }
        }

        return programmesForReview;
    }

    // Retrieve programmes by faculty
    resource function get programmesByFaculty/[string faculty]() returns error|Programme[]{
        Programme[] programmesFaculty = [];
        foreach var item in programmes {
            if item.faculty == faculty {
                programmesFaculty.push(item);
            }
        }

        return programmesFaculty;
    }
}

