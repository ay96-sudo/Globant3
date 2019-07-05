import XCTest
@testable import Globant3

class InformationViewModelUnitTests: XCTestCase {
    
    var dummyInformation: Information?
    var sut: InformationViewModel?
    
    override func setUp() {
        super.setUp()
        // given
        guard let path = Bundle.main.url(forResource: "Info", withExtension: "json") else {
            XCTFail("Invalid path for resource")
            return
        }
        guard let data = try? Data(contentsOf: path, options: .alwaysMapped) else {
            XCTFail("The mocked json was not found")
            return
        }
        let decoder = JSONDecoder()
        guard let information = try? decoder.decode(Information.self, from: data) else {
            XCTFail("The information instance could not been decoded")
            return
        }
        dummyInformation = information
        sut = InformationViewModel()
    
    }
    
    func testLoadNilWithIncorrectImage() {
        //given
        let url = Bundle.main.url(forResource: "fake", withExtension: "jpg")
        if let _ = url {
            XCTFail()
        }else {
            XCTAssertNil(url)
            return
        }
    }
    
    func testViewModelBindingCorrectly() {
        guard let sut = sut else {
            XCTFail("The sut is nil")
            return
        }
        guard let dummyInfo = dummyInformation else {
            XCTFail("The dummy info is nil")
            return
        }
        let mockViewController = MockViewController(with: sut)
        sut.updateValues(info: dummyInfo)
        XCTAssertEqual(mockViewController.ageLbl.text, dummyInfo.age)
        XCTAssertEqual(mockViewController.careerLbl.text, dummyInfo.schoolSummary.career)
        XCTAssertEqual(mockViewController.cellPhoneLbl.text, dummyInfo.contactInfo.cellphone)
        XCTAssertEqual(mockViewController.cityLbl.text, dummyInfo.city)
        XCTAssertEqual(mockViewController.emailLbl.text, dummyInfo.contactInfo.email)
        XCTAssertEqual(mockViewController.firstNameLbl.text, dummyInfo.firstName)
        XCTAssertEqual(mockViewController.generationLbl.text, dummyInfo.schoolSummary.generation)
        XCTAssertEqual(mockViewController.lastNameLbl.text, dummyInfo.lastName)
        XCTAssertEqual(mockViewController.linkedInLbl.text, dummyInfo.contactInfo.linkedIn)
        XCTAssertEqual(mockViewController.skillsLbl.text, dummyInfo.skills.joined(separator: "\n"))
    }
    
    func testGetInformationWasCalledOnce() {
        // given
        let resumeService = MockResumeService()
        let sut = InformationViewModel(resumeService: resumeService)
        
        // when
        sut.requestProfileInformation()
        
        // then
        XCTAssertEqual(resumeService.getInformationWasCalled, 1)
    }
    
    func testGetImageWasCalledOnce() {
        // given
        let resumeService = MockResumeService()
        let sut = InformationViewModel(resumeService: resumeService)
        
        // when
        sut.requestPhoto(from: "dummyString")
        
        // then
        XCTAssertEqual(resumeService.getImageWasCalled, 1)
    }
    
    override func tearDown() {
        dummyInformation = nil
        sut = nil
        super.tearDown()
    }
}
