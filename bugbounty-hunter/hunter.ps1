param (
    [string]$target,
    [string]$outputDir = "./output"
)

$tools = ".\tools"
$payloads = ".\payloads"
mkdir $outputDir -ErrorAction SilentlyContinue

function SubdomainEnum {
    Write-Host "[*] Enumerating subdomains..."
    python3 -c "
import dns.resolver
subs = ['www', 'mail', 'dev', 'api', 'test']
for sub in subs:
    try:
        fqdn = f'{sub}.$($target)'
        dns.resolver.resolve(fqdn)
        print(fqdn)
    except: pass
" | Out-File "$outputDir\subdomains.txt"
}

function LiveHosts {
    Write-Host "[*] Checking live hosts..."
    Get-Content "$outputDir\subdomains.txt" | ForEach-Object {
        $url = "http://$_"
        try {
            $r = Invoke-WebRequest -Uri $url -TimeoutSec 5
            if ($r.StatusCode -eq 200) {
                "$url" | Out-File "$outputDir\livehosts.txt" -Append
            }
        } catch {}
    }
}

function PortScan {
    Write-Host "[*] Running Nmap scan..."
    Get-Content "$outputDir\livehosts.txt" | ForEach-Object {
        $domain = ($_ -replace "http://", "")
        nmap -Pn -T4 -p- $domain | Out-File "$outputDir\nmap_$domain.txt"
    }
}

function DirFuzz {
    Write-Host "[*] Fuzzing directories with ffuf..."
    Get-Content "$outputDir\livehosts.txt" | ForEach-Object {
        .\tools\ffuf.exe -w .\tools\wordlist.txt -u "$_/FUZZ" -mc 200 -t 50 -o "$outputDir\ffuf_$(($_ -replace 'http://', '').Replace('.', '_')).json"
    }
}

function BasicVulnScan {
    Write-Host "[*] Scanning basic vulnerabilities..."
    Get-Content "$outputDir\livehosts.txt" | ForEach-Object {
        $url = $_
        foreach ($xss in Get-Content "$payloads\xss.txt") {
            $test = "$url?input=$xss"
            $res = Invoke-WebRequest -Uri $test -UseBasicParsing -ErrorAction SilentlyContinue
            if ($res.Content -like "*$xss*") {
                "[XSS] $test" | Out-File "$outputDir\xss_results.txt" -Append
            }
        }
    }
}

SubdomainEnum
LiveHosts
PortScan
DirFuzz
BasicVulnScan