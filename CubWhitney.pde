class CubWhitney{
  float x_sup;
  float y_sup;
  float size;
  float x_Q;
  float y_Q;
  int dins_r, dins_g, dins_b, dins_alpha, fora_r, fora_g, fora_b, fora_alpha; 
  int[] veins;
  
  CubWhitney(float a, float b, float c){
    //coordenades del centre
    x_Q=a;
    y_Q=b;
    //cantonada superior
    x_sup=a-c/2;
    y_sup=b-c/2;
    //mida del cub
    size=c;    
    dins_r=255;
    dins_g=255;
    dins_b=255;
    dins_alpha=0;
    fora_r=0;
    fora_g=0;
    fora_b=0;
    fora_alpha=60;    
    veins = new int[0];
  }
  
  void incrementa(float i, float j){
    x_Q+=i;
    x_sup+=i;
    y_Q+=j;
    y_sup+=j;
  }
  
  void pinta(){
    stroke(fora_r,fora_g,fora_b,fora_alpha);
    fill(dins_r,dins_g,dins_b,dins_alpha);
    rect(x_sup, y_sup, size, size);
  }

  void coloreja(int a1,  int a2, int a3, int a4, int a5, int a6, int a7, int a8){
    dins_r=a1;
    dins_g=a2;
    dins_b=a3;
    dins_alpha=a4;
    fora_r=a5;
    fora_g=a6;
    fora_b=a7;
    fora_alpha=a8;
  }
  void coloreja(int a1,  int a2, int a3, int a4){
    dins_r=a1;
    dins_g=a2;
    dins_b=a3;
    dins_alpha=a4;
  }
  
  void rePinta(){
    noStroke();
    fill(dins_r,dins_g,dins_b,dins_alpha);
    rect(x_sup+1, y_sup+1, size-1, size-1);
  }

  float distancia(Corba linia)
  {
   float dd = width;
   float aux = width; 
   int indicador=0;
   int pas=round(max(size, 1));
   
   for(int j=0; j<linia.parts; j++){
     for(int i=0; i<linia.vecc[j]; ){
       aux=(dist(x_Q,y_Q,linia.punts[j][2*i], linia.punts[j][2*i+1]));
       dd=min(dd, aux);
       indicador=i;
       i=i+1+floor(aux/(2*precisio));
     }
     for(int i=max(indicador-precisio*pas,0); i<min(indicador+precisio*pas, linia.vecc[j]); i=i+1){
       dd=min(dd, dist(x_Q,y_Q,linia.punts[j][2*i], linia.punts[j][2*i+1]));
     }
     for(int i=max(0,linia.vecc[j]-precisio*pas+indicador); i<linia.vecc[j]; i=i+1){
       dd=min(dd, dist(x_Q,y_Q,linia.punts[j][2*i], linia.punts[j][2*i+1]));
     } 
     for(int i=0; i<min(linia.vecc[j], indicador+precisio*pas-linia.vecc[j]); i=i+1){
       dd=min(dd, dist(x_Q,y_Q,linia.punts[j][2*i], linia.punts[j][2*i+1]));
     }
   }
    return dd;
  }

  boolean esDins(Corba linia)
  {
    float suma=0, angle, cub=size;
    float aux=width;
    int midabona;
    int i;  
    int signe=1;
    
    for(int j=0; j<linia.parts;j++){ 
      i=0;
      aux=(dist(x_Q,y_Q,linia.punts[j][0], linia.punts[j][1])/2); 
      midabona=min(round(aux)/precisio, linia.vecc[j]/16);
      midabona=max(mida_min, midabona);
 
      for(;i<linia.vecc[j]-midabona;)
      {
        aux=(dist(x_Q,y_Q,linia.punts[j][2*i], linia.punts[j][2*i+1])/16); 
        midabona=min(round(aux)/precisio, linia.vecc[j]/16);
        midabona=max(mida_min, midabona);

        u.set(linia.punts[j][2*i]-x_Q,linia.punts[j][2*i+1]-y_Q,0); 
        v.set(linia.punts[j][2*i+2*midabona]-x_Q, linia.punts[j][2*i+2*midabona+1]-y_Q,0);
        angle=PVector.angleBetween(u,v);
        if(u.x*v.y-u.y*v.x>0)
        {
          suma+=angle;
        }
        else{ 
          suma-=angle;
        }
        i+=midabona;
      }
    
      u.set(linia.punts[j][2*i]-x_Q,linia.punts[j][2*i+1]-y_Q,0); 
      v.set(linia.punts[j][0]-x_Q, linia.punts[j][1]-y_Q,0);
      angle=PVector.angleBetween(u,v);
      if(u.x*v.y-u.y*v.x>0)
      {
        suma+=angle;
      }
      else{
        suma-=angle;
      }
    }

    if(suma<0) {signe=-1;}
    for( ; suma*signe>=0 ;suma-= signe*4*PI){
      if((suma<-PI && suma >-3*PI)|| (suma>PI&&suma<3*PI))  return true;
    }
    
    return false;
  } 
}