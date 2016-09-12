Button bSanathBell;
Button bClassicalQuantum;
Button bSyncOppRandom;
Button bStandardSnap;

void setupUI()
{
  with (pjsCM)
  {
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 3, START_OPENED);
    
    bSanathBell = addButton(.05, .1, .25, .8, "Sanath1");
    bClassicalQuantum = addButton(.35, .1, .25, .8, "Classical");
    bSyncOppRandom = addButton(.65, .1, .1, .8, "Sync");
    bStandardSnap = addButton(.8, .1, .15, .8, "Analog");
    
    updateUIState();
    createExperiment();
  }
  
  resetData();
}

void processUI()
{
  if (bSanathBell != null && bSanathBell.doProcess == true) 
  {
    if (experimentId == 0) experimentId = 1;
    else if (experimentId == 1) experimentId = 2;
    else if (experimentId == 2) experimentId = 3;
    else if (experimentId == 3) experimentId = 4;
    else if (experimentId == 4) experimentId = 5;
    else if (experimentId == 5) experimentId = 6;
    else if (experimentId == 6) experimentId = 7;
    else if (experimentId == 7) experimentId = 8;
    else if (experimentId == 8) experimentId = 9;
    else if (experimentId == 9) experimentId = 10;
    else if (experimentId == 10) experimentId = 0;
    
    createExperiment();
    updateUIState();
    clearData();
  }
  
  if (bClassicalQuantum != null && bClassicalQuantum.doProcess == true) 
  {
    if (isClassicalQuantum == 0) isClassicalQuantum = 1;
    else if (isClassicalQuantum == 1) isClassicalQuantum = 0;
    updateUIState();
    clearData();
  }
  
  if (bSyncOppRandom != null && bSyncOppRandom.doProcess == true) 
  {
    if (isSyncOppRandom == 0) isSyncOppRandom = 1;
    else if (isSyncOppRandom == 1) isSyncOppRandom = 2;
    else if (isSyncOppRandom == 2) isSyncOppRandom = 0;
    updateUIState();
    clearData();
  }

  if (bStandardSnap != null && bStandardSnap.doProcess == true) 
  {
    if (isStandardSnap == 0) isStandardSnap = 1;
    else if (isStandardSnap == 1) isStandardSnap = 0;
    updateUIState();
    clearData();
  }
}

void updateUIState()
{
  bSanathBell.txt = experiment.title;
  /*if (experimentId == 0) bSanathBell.txt = experiment.title;
  else if (experimentId == 1) bSanathBell.txt = "Sanath - 2";
  else if (experimentId == 2) bSanathBell.txt = "Web - a";
  else if (experimentId == 3) bSanathBell.txt = "Web - b";
  else if (experimentId == 4) bSanathBell.txt = "Web - c";
  else if (experimentId == 5) bSanathBell.txt = "YouTube";
  else if (experimentId == 6) bSanathBell.txt = "Book";
  else if (experimentId == 7) bSanathBell.txt = "Jim Al-Khalili - 1";
  else if (experimentId == 8) bSanathBell.txt = "Jim Al-Khalili - 2";
  else if (experimentId == 9) bSanathBell.txt = "Bell's Original";
  else if (experimentId == 10) bSanathBell.txt = "Alain Aspect";*/
  
  if (isClassicalQuantum == 0) bClassicalQuantum.txt = "Classical";
  else if (isClassicalQuantum == 1) bClassicalQuantum.txt = "Quantum";

  bSyncOppRandom.isDisabled = (isClassicalQuantum == 1);
  if (isSyncOppRandom == 0) bSyncOppRandom.txt = "Sync";
  else if (isSyncOppRandom == 1) bSyncOppRandom.txt = "Opp";
  else if (isSyncOppRandom == 2) bSyncOppRandom.txt = "Rnd";
    
  bStandardSnap.isDisabled = (isClassicalQuantum == 1);
  if (isStandardSnap == 0) bStandardSnap.txt = "Standard";
  else if (isStandardSnap == 1) bStandardSnap.txt = "Snap";
}

void createExperiment()
{
  if (experimentId == 0) experiment = new Sanath_1();
  else if (experimentId == 1) experiment = new Sanath_2();
  else if (experimentId == 2) experiment = new Bell_1_Web_a();
  else if (experimentId == 3) experiment = new Bell_1_Web_b();
  else if (experimentId == 4) experiment = new Bell_1_Web_c();
  else if (experimentId == 5) experiment = new Bell_2_YouTube();
  else if (experimentId == 6) experiment = new Bell_3_Book();
  else if (experimentId == 7) experiment = new Bell_4_Jim_Al_Khalili_1();
  else if (experimentId == 8) experiment = new Bell_4_Jim_Al_Khalili_2();
  else if (experimentId == 9) experiment = new Bell_5_Bell_Original();
  else if (experimentId == 10) experiment = new Bell_6_Alain_Aspect();
}

void clearData()
{
  A.count = 0;
  A.clicks = 0;
  B.count = 0;
  B.clicks = 0;
  experiment.reset();
}



void drawHUD(var g)
{   
}

void resetData()
{
  //use data
}

void saveData()
{
  //save into data
}