import XCTest
@testable import Rentateam

class RentateamTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testApiData() throws {
        API.get(to: Host.photos.random[10], with: { (data) in
            do {
                let data = try data.get()
                XCTAssert(data != nil)
            } catch {
                XCTFail(error.localizedDescription)
            }
        })
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
