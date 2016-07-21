//////////////////////////////////////////////////////////////////
function CloseRequestResultPopup(ContainerDiv) {
    //$("#RequestResultDiv").dialog("close");
    window.location.href = "#";
    if (ContainerDiv.indexOf("Individual") != -1) {
        IndividualReloadPatientRequest();
    }
    else if (ContainerDiv.indexOf("Contract") != -1) {
        ContractReloadPatientRequest();
    }
    else if (ContainerDiv.indexOf("LabToLab") != -1) {
        LabToLabReloadPatientRequest();
    }
}