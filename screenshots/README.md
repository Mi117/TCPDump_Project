# Screenshots — walkthrough index

Visual proof of the lab work, grouped by course task. All captures were taken inside the
Kali Linux VM (see `environment-virtualbox-kali.png`).

| File | Task | Shows |
|---|---|---|
| `environment-virtualbox-kali.png` | env | Kali Linux running in Oracle VirtualBox |
| `task1-basic-commands.png` | 1 | `tcpdump` basic live capture output |
| `task1-basic-commands-detailed.png` | 1 | Basic capture with verbose protocol detail |
| `task2-list-interfaces.png` | 2 | `tcpdump -D` — listing interfaces |
| `task2-tcpdump-d-output.png` | 2 | `-D` output: `eth0`, `any`, `lo`, bluetooth, netfilter |
| `task2-isolate-interface.png` | 2 | `tcpdump -i eth0` — isolating one interface |
| `task2-capture-on-eth0.png` | 2 | Traffic captured on `eth0` only |
| `task2-filter-src-dst-port-host.png` | 2 | Filtering by `src` / `dst` / `port` / `host` |
| `task2-project-scripts-listing.png` | 2 | `ls -al` of `~/tcpdump_project` scripts |
| `task2-chmod-script.png` | 2 | `chmod 777 watchdog.sh` — making a script executable |
| `task2-watchdog-script-vscode.png` | 2 | `watchdog.sh` source in VS Code |
| `task3-create-capture-file.png` | 3 | Creating a capture file with `-w` |
| `task3-pcap-raw-in-vscode.png` | 3 | `.pcap` opened in a text editor — binary data |
| `task3-wireshark-encrypted-data.png` | 3 | Wireshark view showing encrypted application data |
| `task4-size-limit-1mb.png` | 4 | Capture limited to 1 MB per file (`-C 1`) |
| `task4-multiple-capture-files.png` | 4 | Sequential dumps — multiple capture files |
| `task5-key-extraction-script.png` | 5 | `key_extraction.sh` — `SSLKEYLOGFILE` + capture |
| `task5-wireshark-preferences.png` | 5 | Wireshark *Edit → Preferences* |
| `task5-wireshark-protocols-tls.png` | 5 | Wireshark *Protocols → TLS* pre-master-secret log |
| `task5-nasa-tls-handshake.png` | 5 | Decoded TLS handshake to `apd.nasa.gov` |

## Naming

Files were renamed to URL-safe slugs for reliable rendering on GitHub:

```text
1_Basic commands.png                                  -> task1-basic-commands.png
1.2_basic command with detailes.png                   -> task1-basic-commands-detailed.png
2_list all the interfaces.png                         -> task2-list-interfaces.png
001.png                                               -> task2-tcpdump-d-output.png
2.1_isolate the interfaces with -i command.png        -> task2-isolate-interface.png
002.png                                               -> task2-capture-on-eth0.png
2.2_isolate the packets based on the specs_...png     -> task2-filter-src-dst-port-host.png
004.png                                               -> task2-project-scripts-listing.png
005.png                                               -> task2-chmod-script.png
006.png                                               -> task2-watchdog-script-vscode.png
3_command to create the a file with the capture ...    -> task3-create-capture-file.png
3.1_display the capture packets in vscode.png         -> task3-pcap-raw-in-vscode.png
3.3_showing the capture on wireshark and see the ...   -> task3-wireshark-encrypted-data.png
4_ capturimng packes limiting sie to 1MB.png          -> task4-size-limit-1mb.png
4.1_Multiple capture files.png                        -> task4-multiple-capture-files.png
007.png                                               -> task5-wireshark-preferences.png
009.png                                               -> task5-wireshark-protocols-tls.png
010.png                                               -> task5-key-extraction-script.png
011.png                                               -> task5-nasa-tls-handshake.png
2025-06-17 ... VirtualBox.png                         -> environment-virtualbox-kali.png
```

Original filenames remain available in the git history of the first commit.
