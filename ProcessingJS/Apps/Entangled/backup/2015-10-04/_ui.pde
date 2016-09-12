Button bSanathBell;
Button bSyncOppRandom;
Button bClassicalQuantum;
Button bStandardSnap;

void setupUI()
{
  with (pjsCM)
  {
    setupCM(SHOW_AS_HORIZONTAL, SHOW_AT_BOTTOM, 3, START_OPENED);
    
    bSanathBell = addButton(.05, .1, .25, .8, "Sanath1");
    bSyncOppRandom = addButton(.35, .1, .1, .8, "Sync");
    bClassicalQuantum = addButton(.5, .1, .25, .8, "Classical");
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
    else if (experimentId == 1) experimentId = 0;
    
    createExperiment();
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
  
  if (bClassicalQuantum != null && bClassicalQuantum.doProcess == true) 
  {
    if (isClassicalQuantum == 0) isClassicalQuantum = 1;
    else if (isClassicalQuantum == 1) isClassicalQuantum = 0;
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
  if (experimentId == 0) bSanathBell.txt = "Sanath 1";
  else if (experimentId == 1) bSanathBell.txt = "Sanath 2";

  if (isSyncOppRandom == 0) bSyncOppRandom.txt = "Sync";
  else if (isSyncOppRandom == 1) bSyncOppRandom.txt = "Opp";
  else if (isSyncOppRandom == 2) bSyncOppRandom.txt = "Rnd";
    
  if (isClassicalQuantum == 0) bClassicalQuantum.txt = "Classical";
  else if (isClassicalQuantum == 1) bClassicalQuantum.txt = "Quantum";
  
  bStandardSnap.isDisabled = (isClassicalQuantum == 1);
  if (isStandardSnap == 0) bStandardSnap.txt = "Standard";
  else if (isStandardSnap == 1) bStandardSnap.txt = "Snap";
}

void createExperiment()
{
  if (experimentId == 0) experiment = new Sanath1();
    else if (experimentId == 1) experiment = new Sanath2();
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