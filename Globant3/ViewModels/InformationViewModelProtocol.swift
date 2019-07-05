import Foundation
import UIKit

typealias Updater = (() -> Void)
typealias Consumer<T> = ((T) -> Void)

protocol InformationViewModelProtocol {
    
    //MARK: - Main info
    var name: Observable<String> {get}
    var lastname: Observable<String> {get}
    var age: Observable<String> {get}
    var city: Observable<String> {get set}
    var photo: Observable<UIImage> {get set}
    
    var photoString: Observable<String> {get set}
    
    //MARK: - Skills
    var skills: Observable<[String]> {get set}
    
    //MARK: - Work
    var works: [WorkExperienceViewModel] {get set}
    
    //MARK: - Programming
    var languages: [ProgrammingViewModel] {get set}
    
    //MARK: - Education
    var university: Observable<String> {get set}
    var career: Observable<String> {get set}
    var generation: Observable<String> {get set}
    
    //MARK: - Contact
    var email: Observable<String> {get set}
    var cellphone: Observable<String> {get set}
    var linkedin: Observable<String> {get set}
    
    var updateWorkView: Updater? {get set}
    var updateProgramingView: Updater? {get set}
    var showError: Consumer<NetworkError>? {get set}
    
    func requestProfileInformation()
}
