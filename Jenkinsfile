pipeline {
  agent {
    docker { image 'gajju7271/pygcloud' }
  }
  
  stages {
    stage('test') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'abcd', usernameVariable: 'abc')]){
        //withCredentials([file(credentialsId: 'secretidowner', variable: 'GC_KEY')]) {
          //sh("gcloud auth activate-service-account --key-file=${GC_KEY}")
          //sh("python3 app1.py")
          //echo "hii"
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
    stage('bild') {
      steps {
        println('building in test')
      }
    }  
    stage('deploy') {
      steps {
        println('deploying in test')
      }
    }  
  }
}
