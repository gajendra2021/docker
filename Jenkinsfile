pipeline {
  agent {
    docker { image 'gcr.io/google.com/cloudsdktool/cloud-sdk@sha256:9fab3bf49c26444d350c3138f9561319257492a78d8eb7bbac1dd3091436e9b3' }
  }

  stages {
    stage('test') {
      steps {
        withCredentials([file(credentialsId: 'secretidowner', variable: 'GC_KEY')]) {
          sh("gcloud auth activate-service-account --key-file=${GC_KEY}")
          sh("python3 app.py")
          //sh("gcloud config set project sigma-kayak-299307")
          //sh("pip3 install pandas")
          //sh("pip3 install xlrd==1.2.0")
          //sh("gsutil cp gs://ops-all-backup/Firewall-scripts/* .")
          //sh("chmod 777 bastionfw.py stagingfw.py trigger.sh verify.sh")
          //sh("./verify.sh >> Firewall-rule-updated-\$(date +”%d-%m-%Y_%H:%M:%S”).txt")
          //sh("gsutil cp Firewall-rule-updated-* gs://ops-all-backup/fw-update/fw-update-logs/")
        }
      }
    }
  }
}
