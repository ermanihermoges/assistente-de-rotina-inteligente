##################################################
# ASSISTENTE DE ROTINA INTELIGENTE
# Autor: Ermani Hermoges
# Versao: 1.0
# Auditorias: 08h e 18h
# Code. Faith. Discipline.
##################################################

Add-Type -AssemblyName PresentationFramework


# -----------------------------------
# HORARIO
# -----------------------------------

$hora = (Get-Date).Hour


# Executa somente 08h ou 18h
if($true){


    # -----------------------------------
    # BATERIA
    # -----------------------------------

    $bateria = 100

    $batteryInfo = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue

    if($batteryInfo){
        $bateria = $batteryInfo.EstimatedChargeRemaining
    }


    # -----------------------------------
    # ESPACO EM DISCO
    # -----------------------------------

    $disco = Get-PSDrive C

    $livre = [math]::Round($disco.Free / 1GB,1)


    # -----------------------------------
    # INTERNET
    # -----------------------------------

    $internet = Test-Connection google.com -Count 1 -Quiet

    if($internet){
        $statusInternet = "Conectada"
    }
    else{
        $statusInternet = "Sem conexao"
    }


    # -----------------------------------
    # GOOGLE CHROME
    # -----------------------------------

    $chrome = (Get-Process chrome -ErrorAction SilentlyContinue).Count

    if(!$chrome){
        $chrome = 0
    }


    # -----------------------------------
    # TEMPO LIGADO
    # -----------------------------------

    $os = Get-CimInstance Win32_OperatingSystem

    $boot = $os.LastBootUpTime

    $diasLigado = ((Get-Date) - $boot).Days


    # -----------------------------------
    # PONTUACAO
    # -----------------------------------

    $pontuacao = 100

    if($bateria -lt 30){
        $pontuacao -= 20
    }

    if($livre -lt 20){
        $pontuacao -= 20
    }

    if(!$internet){
        $pontuacao -= 20
    }

    if($chrome -gt 10){
        $pontuacao -= 10
    }

    if($diasLigado -gt 3){
        $pontuacao -= 10
    }


    # -----------------------------------
    # INGLES
    # -----------------------------------

    $ingles = @(
        "Opportunity = Oportunidade",
        "Support = Suporte",
        "Discipline = Disciplina"
    )


    # -----------------------------------
    # VERSICULOS
    # -----------------------------------

    $versiculos = @(
        "Be strong and courageous. Seja forte e corajoso.",
        "Walk by faith. Ande pela fe.",
        "Trust in the Lord. Confie no Senhor."
    )


    # -----------------------------------
    # MISSOES
    # -----------------------------------

    $missoes = @(
        "Subir 1 projeto no GitHub.",
        "Aplicar para 2 vagas.",
        "Estudar 30 minutos.",
        "Organizar sua pasta de projetos."
    )


    $fraseIngles = Get-Random $ingles
    $versiculo = Get-Random $versiculos
    $missao = Get-Random $missoes


    # -----------------------------------
    # PAINEL
    # -----------------------------------

    $texto = @"
ASSISTENTE DE ROTINA INTELIGENTE

Usuario: $env:USERNAME
Horario: $hora`:00


SAUDE DO SISTEMA

Bateria: $bateria%
Espaco livre: $livre GB
Internet: $statusInternet
Google Chrome: $chrome processos
Tempo ligado: $diasLigado dias


Pontuacao geral: $pontuacao / 100


INGLES DO DIA

$fraseIngles


VERSICULO DO DIA

$versiculo


MISSAO DE HOJE

$missao


Code. Faith. Discipline.
Ermani Tech Labs
"@


    [System.Windows.MessageBox]::Show(
        $texto,
        "Assistente de Rotina Inteligente"
    )

}