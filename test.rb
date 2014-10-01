API_KEY = ENV['FACER_KEY']
require_relative "./scripts/enroll_subject.rb"
require_relative "./scripts/recognize_subject.rb"
require_relative "./scripts/galleries.rb"


# FaceR::EnrollSubject.run("./C7/Jwarren.JPG", "MKS", "Jeremy")
# FaceR::Galleries.view_galleries
# FaceR::Galleries.view_subjects("MKS")

FaceR::RecognizeSubject.run("./TestPhotos/sachin.jpeg", "MKS")



