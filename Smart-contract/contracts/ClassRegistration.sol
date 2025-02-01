// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClassRegistration {
    address public admin;
    
    struct Student {
        string name;
        bool isRegistered;
    }
    
    // Mapping from student ID to Student struct
    mapping(uint256 => Student) public students;
    
    // Array to keep track of all student IDs
    uint256[] public studentIds;
    
    // Events
    event StudentRegistered(uint256 studentId, string name);
    event StudentRemoved(uint256 studentId);
    
    // Constructor sets the contract deployer as admin
    constructor() {
        admin = msg.sender;
    }
    
    // Modifier to restrict access to admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }
    
    // Register a new student
    function registerStudent(uint256 _studentId, string memory _name) public onlyAdmin {
        require(!students[_studentId].isRegistered, "Student ID already exists");
        require(bytes(_name).length > 0, "Name cannot be empty");
        
        students[_studentId] = Student({
            name: _name,
            isRegistered: true
        });
        
        studentIds.push(_studentId);
        
        emit StudentRegistered(_studentId, _name);
    }
    
    // Remove a student
    function removeStudent(uint256 _studentId) public onlyAdmin {
        require(students[_studentId].isRegistered, "Student does not exist");
        
        students[_studentId].isRegistered = false;
        
        // Remove student ID from array
        for (uint i = 0; i < studentIds.length; i++) {
            if (studentIds[i] == _studentId) {
                studentIds[i] = studentIds[studentIds.length - 1];
                studentIds.pop();
                break;
            }
        }
        
        emit StudentRemoved(_studentId);
    }
    
    // Get student details by ID
    function getStudent(uint256 _studentId) public view returns (string memory name, bool isRegistered) {
        Student memory student = students[_studentId];
        return (student.name, student.isRegistered);
    }
    
    // Get all registered student IDs
    function getAllStudentIds() public view returns (uint256[] memory) {
        return studentIds;
    }
}