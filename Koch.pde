void fractal() {
  int pas = 2*floor(pow(4,iterkoch));
  int longitudmax=min(width,height);
  
  components=1;
  vec = new int[1];
  vertexIniciat=true;

  koch = new float[1][6*floor(pow(4,iterkoch))+2]; 

//  koch[0][0] = (2*0.9-0.5)*longitudmax;
//  koch[0][1] = 2*0.273*longitudmax;
  koch[0][0] = (0.9)*longitudmax;
  koch[0][1] = 0.273*longitudmax;
  koch[0][3*pas] = koch[0][0];
  koch[0][3*pas+1] = koch[0][1];
//  koch[0][pas] = (2*0.1-0.5)*longitudmax;
//  koch[0][pas+1] = 2*0.273*longitudmax;
  koch[0][pas] = (0.1)*longitudmax;
  koch[0][pas+1] = 0.273*longitudmax;
  koch[0][2*pas] = (koch[0][3*pas]+koch[0][pas])/2 - (koch[0][3*pas+1]-koch[0][pas+1])*sqrt(3)/2;
  koch[0][2*pas+1] = (koch[0][3*pas+1]+koch[0][pas+1])/2 + (koch[0][3*pas]-koch[0][pas])*sqrt(3)/2;
  vec[0] = (koch[0].length+1)/2;

  for(int i=1; i<=iterkoch; i++){
    pas = 2*floor(pow(4,iterkoch-i));
    for(int j=pas; j < koch[0].length; j += 4*pas){
      //Tallem el segment en tres trossos
      koch[0][j]=koch[0][j-pas]*2./3.+koch[0][j+3*pas]*1./3.;
      koch[0][j+1]=koch[0][j-pas+1]*2./3.+koch[0][j+3*pas+1]*1./3.;
      koch[0][j+2*pas]=koch[0][j-pas]*1./3.+koch[0][j+3*pas]*2./3.;
      koch[0][j+2*pas+1]=koch[0][j-pas+1]*1./3.+koch[0][j+3*pas+1]*2./3.;
      //Fabriquem la punta del triangle equilater      
      koch[0][j+pas]=(koch[0][j+2*pas]+koch[0][j])/2 - (koch[0][j+2*pas+1]-koch[0][j+1])*sqrt(3)/2;
      koch[0][j+pas+1]= (koch[0][j+2*pas+1]+koch[0][j+1])/2 + (koch[0][j+2*pas]-koch[0][j])*sqrt(3)/2;
    }
  }
}