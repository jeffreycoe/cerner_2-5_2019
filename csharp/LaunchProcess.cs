// cerner_2^5_2019
// Launches process and waits for the process to complete

using System;
using System.Collections;
using System.Collections.Generic;
using System.ServiceProcess;

private static Dictionary<String, String> LaunchProcess(String workingDirectory, String binaryPath, String args)
{
    Dictionary<String, String> procResult = new Dictionary<String, String>();
    Process proc = new Process();
    ProcessStartInfo startInfo = new ProcessStartInfo(binaryPath, args) {
        CreateNoWindow = true,
        UseShellExecute = false,
        WorkingDirectory = Path.GetDirectoryName(workingDirectory),
        RedirectStandardError = true,
        RedirectStandardOutput = true
    };
    
    proc.StartInfo = startInfo;
    proc.Start();
    proc.WaitForExit();

    procResult.Add("stdout", proc.StandardOutput.ReadToEnd());
    procResult.Add("stderr", proc.StandardError.ReadToEnd());
    procResult.Add("exitcode", proc.ExitCode.ToString());

    if (proc.ExitCode > 0) {
        throw new Exception("LaunchProcess: Process exited with exit code " + procResult["exitcode"] + ".\nStdout: " + procResult["stdout"] + "\nStderr: " + procResult["stderr"]);
    }

    proc.Close();
    return procResult;
}