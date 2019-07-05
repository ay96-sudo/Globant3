import XCTest

class Globant3UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testProfileImageViewExists() {
        XCTAssertTrue(app.images["profileImageView"].exists)
    }
    
    // MARK: - Card sections exists
    func testMainCardExists() {
        XCTAssertTrue(app.otherElements["main_card_id"].exists)
    }
    
    func testSkillsExists() {
        XCTAssertTrue(app.otherElements["skills_card_id"].exists)
    }
    
    func testWorkCardExists() {
        XCTAssertTrue(app.otherElements["work_card_id"].exists)
    }

    func testProgrammingCardExists() {
        XCTAssertTrue(app.otherElements["programming_card_id"].exists)
    }

    func testEducationCardExists() {
        XCTAssertTrue(app.otherElements["education_card_id"].exists)
    }

    func testContantCardExists() {
        XCTAssertTrue(app.otherElements["contact_card_id"].exists)
    }
    
    
    // MARK: - Labels exists
    func testNameLabelExists() {
        XCTAssertTrue(app.staticTexts["nameLabel"].exists)
    }
    
    func testLastnameLabelExists() {
        XCTAssertTrue(app.staticTexts["lastnameLabel"].exists)
    }
    
    func testAgeLabelExists() {
        XCTAssertTrue(app.staticTexts["ageLabel"].exists)
    }
    
    func testCityLabelExists() {
        XCTAssertTrue(app.staticTexts["cityLabel"].exists)
    }
    
    func testSkillsTitleExists() {
        XCTAssertTrue(app.staticTexts["skillsTitle"].exists)
    }
    
    func testWorkTitleExists() {
        XCTAssertTrue(app.staticTexts["workTitle"].exists)
    }
    
    func testProgrammingTitleExists() {
        XCTAssertTrue(app.staticTexts["programmingTitle"].exists)
    }
    
    func testEducationTitleExists() {
        XCTAssertTrue(app.staticTexts["educationTitle"].exists)
    }
    
    func testUniversityLabelExists() {
        XCTAssertTrue(app.staticTexts["universityLabel"].exists)
    }
    
    func testCareerLabelExists() {
        XCTAssertTrue(app.staticTexts["careerLabel"].exists)
    }
    
    func testGenerationLabelExists() {
        XCTAssertTrue(app.staticTexts["generationLabel"].exists)
    }
    
    func testContactTitleExists() {
        XCTAssertTrue(app.staticTexts["contactTitle"].exists)
    }
    
    func testEmailLabelExists() {
        XCTAssertTrue(app.staticTexts["emailLabel"].exists)
    }
    
    func testCellLabelExists() {
        XCTAssertTrue(app.staticTexts["cellLabel"].exists)
    }
    
    func testLinkLabelExists() {
        XCTAssertTrue(app.staticTexts["linkLabel"].exists)
    }

}
