# TABLE 1	
print TMP "SPOTREP - $sprfrm\n";
print TMP "R: $sprtmedte\n";
print TMP "FROM: $sprfrm\n";
print TMP "TO: $sprto\n";
print TMP "INFO (CC): $sprcc\n";

# TABLE 2
# 1
print TMP "1. City/State/Territory: $sprcst\n";
# 2
print TMP "2. LandLine works? $choose2\n";
print TMP "$comm2\n";
# 3
print TMP "3. Cell Phone Works? $choose3\n";
print TMP "$comm3\n";
# 4
print TMP "4. AM/FM Broadcast Stations Status\n";
print TMP "$comm4\n";
# 5
print TMP "5. TV Stations Status\n";
print TMP "$comm5\n";
# 6
print TMP "6. Public Water Works Status\n";
print TMP "$comm6\n";
# 7
print TMP "7. Commercial Power Status\n";
print TMP "$comm7\n";
# 8
print TMP "8. Internet Working? $choose8\n";
print TMP "$comm8\n";

# TABLE 3
print TMP "Additional Comments\n";
print TMP "$comm9\n";

# TABLE 4
print TMP "POC\n";
print TMP "$sprpoc\n";