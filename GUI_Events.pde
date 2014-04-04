//GP4 Events


public void handleTextEvents(GEditableTextControl textcontrol, GEvent event) {
    if (event == GEvent.ENTERED) {
       if (GUIlocked == false) {  //Lock Gui when knitting
                // change WorkingWidth after KeyPressReturn
                    if (textcontrol == txtfieldWorkingWidth){
                      if (int(txtfieldWorkingWidth.getText()) > 0 &&  int(txtfieldWorkingWidth.getText()) < totalWidth+1){
                             workingWidth = int(txtfieldWorkingWidth.getText()); 
                      }
                    }
       }
    }

}


void handleButtonEvents(GButton button, GEvent event) { 
  if (event == GEvent.CLICKED) {
    
    if (GUIlocked == false) {  //Lock Gui when knitting
            
            if (button == btnSetWorkingWidth){
              
                if (int(txtfieldWorkingWidth.getText()) > 0 &&  int(txtfieldWorkingWidth.getText()) < totalWidth+1){
                       workingWidth = int(txtfieldWorkingWidth.getText()); 
                }
               }
            if (button == btnOpenPatterImageFile)
               loadPatternImageFile();
           
            if (button == btnPatternImageMirror)
              mirrorPatternImageX();
            
        
          //scale      
             if (button == btnPatternScaleYplus)
               patternScaleY++;   
              
             if (button == btnPatternScaleYminus){
                  patternScaleY--;
                  if (patternScaleY==0) {
                    patternScaleY=1;
                  }
               }
        
             if (button == btnPatternScaleXplus)
               patternScaleX++;   
              
             if (button == btnPatternScaleXminus){
                  patternScaleX--;
                  if (patternScaleX==0) {
                    patternScaleX=1;
                    }      
                }
                
          // Pattern Grid
              if (button == btnPatternGridXplus)
               patternGridX++;   
              
             if (button == btnPatternGridXminus){
                  patternGridX--;
                  if (patternGridX==0) {
                    patternGridX=1;
                    }      
                }
                   if (button == btnPatternGridYplus)
               patternGridY++;   
              
             if (button == btnPatternGridYminus){
                  patternGridY--;
                  if (patternGridY==0) {
                    patternGridY=1;
                  }
               }  
                
          // Pattern Grid Gap
              if (button == btnPatternGridGapXplus)
               patternGridXgap++;   
              
             if (button == btnPatternGridGapXminus){
                  patternGridXgap--;
                  if (patternGridXgap==-1) {
                    patternGridXgap=0;
                    }      
                }
             
             if (button == btnPatternGridGapYplus)
               patternGridYgap++;   
              
             if (button == btnPatternGridGapYminus){
                  patternGridYgap--;
                  if (patternGridYgap==-1) {
                    patternGridYgap=0;
                  }
               }       
          // Set Cursor     
                  if (button == btnSetCursor){
                     //println(int(txtfieldSetCursor.getText()));
                     sendCommand(COM_CMD_CURSOR, txtfieldSetCursor.getText());   
                     txaInformationBox.appendText("Cursor Set");
                  }
        
         // Set Border
        
                  if (button == btnSetBorder){
                      SetBorderToggle = !SetBorderToggle;
                  
                  }
                  
            if (button == btnKnitInvers)
              inversePatternImage();
        
            if (button == btnOneRowBack)
               movePatternY--;
        
            if (button == btnKnitOneRow)
               buttonKnitRow();
               
    }        
       
       
       
    if (button == btnKnitStart){
       GUIlocked = true;
       knittigInProgress = true;
       buttonKnitRow();
       btnKnitStart.setLocalColorScheme(GP4colorSchemeActive);
       btnKnitPause.setLocalColorScheme(GP4colorScheme);
      }
      
    if (button == btnKnitPause){
       GUIlocked = false;
       knittigInProgress = false;
       btnKnitStart.setLocalColorScheme(GP4colorScheme);
       btnKnitPause.setLocalColorScheme(GP4colorSchemeActive);
       //erase last row
       sendCommand(COM_CMD_PATTERN, "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
      }
      

  
  
        
  //end Buttons      
  }
}


void buttonKnitRow() {

     if (knittigInProgress == true){
       
  
          loadPixels();
        
          myPattern = "";
        
          // println(hex(pixels[(((gridStartY+displayWorkingRow*scalingfactor)+scalingfactor/2)*width) + ((gridStartX+(totalWidth/2-workingWidth/2)*scalingfactor)+scalingfactor/2)]) );
          for (int i = 0; i < workingWidth; i++)
          {
            if ((pixels[(((gridStartY+displayWorkingRow*scalingfactor)+scalingfactor/2)*width) + ((gridStartX+(totalWidth/2-workingWidth/2)*scalingfactor)+scalingfactor/2) + i*scalingfactor] ) == 0xFF000000)
            {
              myPattern += "1";
            }
            else {
              myPattern += "0";
            }
          }
                    
          sendCommand(COM_CMD_PATTERN, myPattern);
          //movePatternY++;  
         println(myPattern);
     }
}

void moveRowInGUI(){
      if (knittigInProgress == true)
      movePatternY++;  

}



