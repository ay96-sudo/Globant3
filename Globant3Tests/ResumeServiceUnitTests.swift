
import XCTest
@testable import Globant3

class ResumeServiceUnitTests: XCTestCase {

    func testGetImageCallsGetImageFromNetworkingOnce() {
        // given
        let dummyNetworking = MockNetworking(session: MockURLSession())
        let sut = ResumeService(networking: dummyNetworking)
        
        guard let dummyUrl = URL(string: "dummyUrl") else {
            XCTFail("This is not a url")
            return
        }
        // when
        sut.getImage(from: dummyUrl) { (result) in
           // Nothing to test here
        }
        // then
        XCTAssertEqual(dummyNetworking.getImageWasCalled, 1)
    }
    
    func testGetInformationCallsGetDataFromNetworkingOnce() {
        // given
        let dummyNetworking = MockNetworking(session: MockURLSession())
        let sut = ResumeService(networking: dummyNetworking)
        // when
        sut.getInformation(endPoint: "dummyEndpoint") { result in
            // Nothing to test here
        }
        // then
        XCTAssertEqual(dummyNetworking.getDataWasCalled, 1)
    }
}
