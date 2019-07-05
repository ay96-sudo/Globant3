
import Foundation
@testable import Globant3

class MockViewController {
    //MARK: - IBOutlets
    var userImageView = BoundImageView()
    var firstNameLbl = BoundLabel()
    var lastNameLbl = BoundLabel()
    var ageLbl = BoundLabel()
    var cityLbl = BoundLabel()
    var skillsLbl = BoundLabel()
    var universityLbl = BoundLabel()
    var careerLbl = BoundLabel()
    var generationLbl = BoundLabel()
    var emailLbl = BoundLabel()
    var cellPhoneLbl = BoundLabel()
    var linkedInLbl = BoundLabel()
    
    init(with infoViewModel: InformationViewModel) {
        userImageView.bind(to: infoViewModel.photo)
        firstNameLbl.bind(to: infoViewModel.name)
        lastNameLbl.bind(to: infoViewModel.lastname)
        ageLbl.bind(to: infoViewModel.age)
        cityLbl.bind(to: infoViewModel.city)
        skillsLbl.bind(to: infoViewModel.skills)
        universityLbl.bind(to: infoViewModel.university)
        careerLbl.bind(to: infoViewModel.career)
        generationLbl.bind(to: infoViewModel.generation)
        emailLbl.bind(to: infoViewModel.email)
        cellPhoneLbl.bind(to: infoViewModel.cellphone)
        linkedInLbl.bind(to: infoViewModel.linkedin)
    }
}
