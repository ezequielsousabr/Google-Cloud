# Função inicia a instalaçao do agente para o Computer Engine - Instancias do Google Cloud.
# Após a instalação é possível monitorar informações do sistema pela plataforma ou pela cli gcloud.

function install_agent {

    if ( (Get-Service -Name StackdriverMonitoring | Select-Object -Unique "Status" ) -eq ("Stopped") -or (Get-Service -Name Stackdrivermonitoring) )
    {

        Write-Output ( "Inicialização do script em: $(Get-Date)" );
        
        Write-Output "";
    
        Write-Output ( "Voce esta logado como: ${env:USERNAME} no Host: Host: ${env:COMPUTERNAME}" ); Start-Sleep 2;
        
        Write-Output "";

        Write-Output ( "Iniciando o download: https://repo.stackdriver.com/windows/StackdriverMonitoring-GCM-46.exe" );

        Start-Sleep 2;

        Write-Output "";

        $ip = $(Invoke-WebRequest -Uri ipinfo.io/ip | Select-Object -Unique "Content");

        Write-Output ( "Seu endereço ip: "+${ip} );

        Write-Output "";

        Start-Sleep 2;

        # Instalação do agente

        (New-Object Net.WebClient).DownloadFile("https://repo.stackdriver.com/windows/StackdriverMonitoring-GCM-46.exe", "${HOME}\Downloads\StackdriverMonitoring-GCM-46.exe")
        & "${HOME}\Downloads\StackdriverMonitoring-GCM-46.exe"

        # Remover o executável baixado

        if ( Get-ChildItem -Filter StackdriverMonitoring-GCM-46.exe ) { Start-Sleep 2;

            Write-Output ( "Buscando o download do executável... Excluindo arquivo baixado!" );

            Get-ChildItem -Filter StackdriverMonitoring-GCM-46.exe; Start-Sleep 4;

            Write-Output ( "Iremos remover o executável baixado. Confirme para excluir ou cancele a operação!" );
        
            Remove-Item -Path ${HOME}\Downloads\StackdriverMonitoring-GCM-46.exe -Confirm;

            Write-Output "";

            Get-Location -Verbose;

        }else {
        
            Write-Output ( "Não encontramos o executável. Por isso, nada será removido... Listando diretório" );

            Start-Sleep 2;

            Get-ChildItem -File;
        
        }

    }
    else
    {

        Write-Output ( "1. Verifique sua conexão com a internet! " );

        Write-Output ""; Start-Sleep 3;

        Get-NetAdapter -InterfaceDescription *;
        
        Write-Output ""; Start-Sleep 2;
        
        Write-Output ( "2. Verifique se o serviço ja esta sendo executado!" );

        Get-Service -Name StackdriverMonitoring;

    }

    Write-Output "";

    Start-Sleep 2; Write-Output ( "Finalizado!" );

}

install_agent