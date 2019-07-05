import UIKit

final class InfoViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userImageView: BoundImageView?
    @IBOutlet weak var basicInformationStackView: UIStackView?
    @IBOutlet weak var educationStackView: UIStackView?
    @IBOutlet weak var contactStackView: UIStackView?
    @IBOutlet weak var firstNameLbl: BoundLabel?
    @IBOutlet weak var lastNameLbl: BoundLabel?
    @IBOutlet weak var ageLbl: BoundLabel?
    @IBOutlet weak var cityLbl: BoundLabel?
    @IBOutlet weak var skillsLbl: BoundLabel?
    @IBOutlet weak var universityLbl: BoundLabel?
    @IBOutlet weak var careerLbl: BoundLabel?
    @IBOutlet weak var generationLbl: BoundLabel?
    @IBOutlet weak var emailLbl: BoundLabel?
    @IBOutlet weak var cellPhoneLbl: BoundLabel?
    @IBOutlet weak var linkedInLbl: BoundLabel?
    @IBOutlet weak var workStackView: UIStackView?
    @IBOutlet weak var programmingStackView: UIStackView?
    
    //MARK: - Titles outletd
    @IBOutlet weak var skillsTitleLbl: UILabel?
    @IBOutlet weak var workTitleLbl: UILabel?
    @IBOutlet weak var programmingTitleLbl: UILabel?
    @IBOutlet weak var educationTitleLbl: UILabel?
    @IBOutlet weak var contactTitleLbl: UILabel?
    
    //MARK: - class variables
    var infoViewModel: InformationViewModelProtocol = InformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "main_title".localize()
        self.navigationController?.navigationBar.prefersLargeTitles = true
       
        infoViewModel.updateProgramingView = { [weak self] in
            self?.configureProgrammingView()
        }
        infoViewModel.updateWorkView = { [weak self] in
            self?.configureWorkView()
        }
        infoViewModel.showError = { [weak self] error in
            self?.showError(error: error)
        }
        configure()
        infoViewModel.requestProfileInformation()
    }
    
    //MARK: - Configure Views
    private func configure() {
        configureBasicInfoConstraints()
        configureEducationConstraints()
        configureContactConstraints()
        configureMainView()
        configureSkillsView()
        configureEducationView()
        configureContactView()
        configureImageView()
        configureWorkView()
        configureProgrammingView()
    }
    
    //Mark: - Configure Constraints
    private func configureBasicInfoConstraints() {
        guard let userImageView = userImageView,
            let basicInformationStackView = basicInformationStackView,
            let superview = userImageView.superview else {
                return
        }
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        basicInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8.0).isActive = true
        userImageView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: Metrics.imageBottomConstraint).isActive = true
        basicInformationStackView.topAnchor.constraint(equalTo: superview.topAnchor, constant: Metrics.verticalStackViewConstraint).isActive = true
        basicInformationStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8.0).isActive = true
        userImageView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8.0).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: Metrics.imageViewWidth).isActive = true
        userImageView.rightAnchor.constraint(equalTo: basicInformationStackView.leftAnchor, constant: -8.0).isActive = true
        basicInformationStackView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8.0).isActive = true
    }
    
    private func configureEducationConstraints() {
        guard let educationTitleLbl = educationTitleLbl,
            let educationStackView = educationStackView,
            let superview = educationStackView.superview else {
                return
        }
        
        educationTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        educationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        educationTitleLbl.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8.0).isActive = true
        educationTitleLbl.bottomAnchor.constraint(equalTo: educationStackView.topAnchor, constant: -8.0).isActive = true
        educationStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8.0).isActive = true
        educationTitleLbl.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8.0).isActive = true
        educationTitleLbl.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8.0).isActive = true
        educationStackView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8.0).isActive = true
        educationStackView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8.0).isActive = true
    }
    
    private func configureContactConstraints() {
        guard let contactTitleLbl = contactTitleLbl,
            let contactStackView = contactStackView,
            let superview = contactTitleLbl.superview else {
                return
        }
        
        contactTitleLbl.translatesAutoresizingMaskIntoConstraints = false
        contactStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contactTitleLbl.topAnchor.constraint(equalTo: superview.topAnchor, constant: 8.0).isActive = true
        contactTitleLbl.bottomAnchor.constraint(equalTo: contactStackView.topAnchor, constant: -8.0).isActive = true
        contactStackView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -8.0).isActive = true
        contactTitleLbl.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8.0).isActive = true
        contactTitleLbl.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8.0).isActive = true
        contactStackView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 8.0).isActive = true
        contactStackView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -8.0).isActive = true
    }
    
    //MARK: - Configure ImageView
    private func configureImageView() {
        userImageView?.bind(to: infoViewModel.photo)
    }
    
    //MARK: - Configure MainView
    private func configureMainView() {
        firstNameLbl?.bind(to: infoViewModel.name)
        lastNameLbl?.bind(to: infoViewModel.lastname)
        ageLbl?.bind(to: infoViewModel.age)
        cityLbl?.bind(to: infoViewModel.city)
    }
    
    //MARK: - Configure SkillsView
    private func configureSkillsView() {
        skillsTitleLbl?.text = "skills_title".localize()
        skillsLbl?.bind(to: infoViewModel.skills)
    }
    
    //MARK: - Configure WorkView
    private func configureWorkView() {
        workTitleLbl?.text = "work_experience_title".localize()
        guard let workStackView = workStackView else { return }
        workStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        infoViewModel.works.forEach { workExperience in
            
            let titleFont = UIFont(name: "HelveticaNeue-Thin", size: 17) ?? UIFont.systemFont(ofSize: 17)
            
            let nameJobTitle = UILabel()
            nameJobTitle.configure(text: "name_title".localize(), font: titleFont)
            
            let nameJob = UILabel()
            nameJob.configure(text: workExperience.company, font: titleFont)
            
            let dateTitle = UILabel()
            dateTitle.configure(text: "date_title".localize(), font: titleFont)
            
            let date = UILabel()
            date.configure(text: workExperience.start, font: titleFont)
            
            let descriptionTitle = UILabel()
            descriptionTitle.configure(text: "description_title".localize(),  font: titleFont)
            
            let description = UILabel()
            description.configure(text: workExperience.description,  font: titleFont)
            
            let nameStack = makeRowStackView(title: nameJobTitle, description: nameJob)
            let dateStack = makeRowStackView(title: dateTitle, description: date)
            let descriptionStack =  makeRowStackView(title: descriptionTitle, description: description)
            
            workStackView.addArrangedSubview(nameStack)
            workStackView.addArrangedSubview(dateStack)
            workStackView.addArrangedSubview(descriptionStack)
        }
    }
    
    private func makeRowStackView(title : UILabel, description: UILabel) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.addArrangedSubview(title)
        rowStackView.addArrangedSubview(description)
        rowStackView.spacing = 30
        return rowStackView
    }
    
    //MARK: - Configure ProgrammingView
    private func configureProgrammingView() {
        programmingTitleLbl?.text = "programming_languages_title".localize()
        guard let programmingStackView = programmingStackView else { return }
        programmingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        infoViewModel.languages.forEach { language in
            
            let titleFont = UIFont(name: "HelveticaNeue-Thin", size: 17) ?? UIFont.systemFont(ofSize: 17)

            let languageLabel = UILabel()
            languageLabel.configure(text: language.name, font: titleFont)
            languageLabel.textAlignment = .left
            
            let timeLabel = BoundLabel()
            timeLabel.configure(text: language.time, font: titleFont)
            timeLabel.textAlignment = .left
            
            let languageStackView = makeRowStackView(title: languageLabel, description: timeLabel)
            
            programmingStackView.addArrangedSubview(languageStackView)
        }
    }
    
    //MARK: - Configure EducationView
    private func configureEducationView () {
        educationTitleLbl?.text = "school_summary_title".localize()
        universityLbl?.bind(to: infoViewModel.university)
        careerLbl?.bind(to: infoViewModel.career)
        generationLbl?.bind(to: infoViewModel.generation)
    }
    
    //MARK: - Configure ContactView
    private func configureContactView(){
        contactTitleLbl?.text = "contact_info_title".localize()
        emailLbl?.bind(to: infoViewModel.email)
        cellPhoneLbl?.bind(to: infoViewModel.cellphone)
        linkedInLbl?.bind(to: infoViewModel.linkedin)
    }
    
    private func showError(error: NetworkError) {
        let alert = UIAlertController(title: "error_title".localize(), message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok_title".localize(), style: .default, handler: nil))
        self.present(alert, animated:  true, completion: nil)
    }
}
