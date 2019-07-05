import UIKit

final class InformationViewModel: InformationViewModelProtocol {
    //MARK: - Class variables
    private let resumeService: ResumeServiceProtocol
    
    init(resumeService: ResumeServiceProtocol =  ResumeService()) {
        self.resumeService = resumeService
    }
    
    private var information: Information?
    
    var name: Observable<String> = Observable("")
    var lastname: Observable<String> =  Observable("")
    var age: Observable<String> = Observable("")
    var city: Observable<String> = Observable("")
    var photo: Observable<UIImage> = Observable(UIImage())
    var photoString: Observable<String> = Observable("")
    var skills: Observable<[String]> = Observable([String]())
    
    var works: [WorkExperienceViewModel] = []
    var languages: [ProgrammingViewModel] = []
    
    var university: Observable<String> = Observable("")
    var career: Observable<String> = Observable("")
    var generation: Observable<String> = Observable("")
    
    var email: Observable<String> = Observable("")
    var cellphone: Observable<String> = Observable("")
    var linkedin: Observable<String> = Observable("")
    
    var updateWorkView: Updater?
    var updateProgramingView: Updater?
    var showError: Consumer<NetworkError>?

    func requestProfileInformation() {
        resumeService.getInformation(endPoint: Endpoints.resume.rawValue) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let model):
                strongSelf.information = model
                DispatchQueue.main.async {
                    strongSelf.updateValues(info: model)
                }
                guard let photoUrl = strongSelf.information?.photo else {
                    return
                }
                strongSelf.requestPhoto(from: photoUrl)
            case .failure(let error):
                strongSelf.showError?(error)
            }
        }
    }
    
    func requestPhoto(from urlString: String) {
        
        guard let urlPhoto = URL(string: urlString) else { return }

        resumeService.getImage(from: urlPhoto) { [weak self] result in
            
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    strongSelf.photo.value = image
                }
            case .failure:
                DispatchQueue.main.async {
                    strongSelf.photo.value = UIImage(named: Constants.ImageNames.defaultImage.rawValue)
                }
            }
        }
    }
    
    func updateValues(info: Information) {
        name.value = info.firstName
        lastname.value = info.lastName
        age.value = info.age
        city.value = info.city
        university.value = info.schoolSummary.university
        career.value = info.schoolSummary.career
        generation.value = info.schoolSummary.generation
        email.value = info.contactInfo.email
        cellphone.value = info.contactInfo.cellphone
        linkedin.value = info.contactInfo.linkedIn
        skills.value = info.skills
        updateStacksValues(info: info)
    }
    
    private func updateStacksValues(info: Information) {
        works.removeAll()
        languages.removeAll()
        info.workExperience?.forEach { job in
            works.append(WorkExperienceViewModel(company: job.company, start: job.start, description: job.description))
        }
        
        info.programming?.forEach { programming in
            languages.append(ProgrammingViewModel(name: programming.language, time: programming.time))
        }
        self.updateWorkView?()
        self.updateProgramingView?()
    }
}


struct ProgrammingViewModel {
    let name: String
    let time: String
}

struct WorkExperienceViewModel {
    let company: String
    let start: String
    let description: String
}
