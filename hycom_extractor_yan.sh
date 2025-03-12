# Fonte e agradecimentos:
# https://www.mathworks.com/matlabcentral/answers/542831-downloading-hycom-data-using-matlab-and-opendap

######################################

# As vezes alguns dados podem estar em falta na própria base da hycom, o que pode resultar em erros não controláveis.

# Instabilidades no servidor podem causar tentativas repetidas e possível falha na extração, deixando o arquivo vazio (sem dados)...
# ...neste caso, isto será informado pelo programa; tente extrair novamente apenas o(s) arquivo(s) específico(s) que falharam em outro horário.

Clear-Host 							
Get-PSSession | Remove-PSSession


### EDITE TODAS AS PARTES ESPECIFICADAS NECESSÁRIAS PARA A EXTRAÇÃO DESEJADA: ###

### DEIXE SEM COMENTÁRIO (retirar o #) apenas a lista de variáveis ($var_list) que se pretende extrair: ###
#$var_list = "surf_el,water_temp,salinity,water_u,water_v"
#$var_list = "water_temp,salinity,water_u,water_v"
#$var_list = "water_temp,salinity"
$var_list = "water_u,water_v"

### DEFINA A BOUNDING BOX: ###
$oeste = 318   ## de  0 a 360 (menor valor de longitude)
$leste = 323   ## de  0 a 360 (maior valor de longitude)
$sul = -26	   ## de -80 a 80 (menor valor de latitude)
$norte = -20   ## de -80 a 80 (maior valor de latitude)

### DEFINA AS DATAS E HORARIOS de ínicio e de término (nota: os anos começam às 12:00): ###
$date_start = '01-Jul-2020 00:00:00'
$date_end = '01-Jul-2024 21:00:00'

### DEFINA A PASTA onde os arquivos serão salvos (se ainda não for existente, será criada uma com esse nome e localização): ###
$resultDirectory = "/arquivos_hycom/currents_hycom_2021-2023/"


If (!(test-path $resultDirectory))
{
    md $resultDirectory
}

$startDate = [datetime]::ParseExact($date_start,'dd-MMM-yyyy HH:mm:ss',$null)
$endDate = [datetime]::ParseExact($date_end,'dd-MMM-yyyy HH:mm:ss',$null)

Write-Host "Baixando dados de " $startDate.ToString('dd-MM-yyyyTHH:mm:ssZ') " até "  $endDate.ToString('dd-MM-yyyyTHH:mm:ssZ')

for ($time = $startDate; $time -le $endDate; $time=$time.AddHours(3)){
$error_flag = 1
$attempts = 0
while (($error_flag -eq 1) -and ($attempts -lt 6)){


	### RETIRE O COMENTÁRIO (retirar o #) apenas da linha do link ($url) desejado: ###

	## DE 1994 ATÉ 2015:                # GLBv0.08/expt 53.X  #
	#$url = "http://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_53.X/data/" + $time.ToString('yyyy') + "?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&time=" + $time.ToString('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"
	
	## DE 7/1/2014 ATÉ 4/30/2016:       # GLBv0.08/expt_56.3 #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_56.3?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"
	
	## DE 5/1/2016 ATÉ 1/31/2017        # GLBv0.08/expt_57.2 #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_57.2?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"
	
	## DE 2/1/2017 ATÉ 5/31/2017        # GLBv0.08/expt_92.8 #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_92.8?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"
	
	## DE 6/1/2017 ATÉ 9/30/2017        # GLBv0.08/expt_57.7 #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_57.7?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"

	## DE 10/1/2017 ATÉ 12/31/2017       # GLBv0.08/expt_92.9  #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_92.9?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"

	## DE 1/1/2018 ATÉ 12/31/2018 ou 2/18/2020    # GLBv0.08/expt_93.0  #
	#$url = "https://ncss.hycom.org/thredds/ncss/GLBv0.08/expt_93.0?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjde=1&time=" + $time.ToStrin Subset=on&horizStrig('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"

	## DE 04-Dec-2018 ATÉ HOJE EM DIA:            # GLBy0.08 expt 93.0  #
	$url = "https://ncss.hycom.org/thredds/ncss/GLBy0.08/expt_93.0?var=" + $var_list + "&norte=" + $norte.ToString() + "&oeste=" + $oeste.ToString() + "&leste=" + $leste.ToString() + "&sul=" + $sul.ToString() + "&disableLLSubset=on&disableProjSubset=on&horizStride=1&time=" + $time.ToString('yyyy-MM-ddTHH:mm:ssZ') + "&accept=netcdf4"



	$fileName = $time.ToString('yyyy_MM_dd-HH') + ".nc"
	$output = $resultDirectory + $fileName

	Try{
		$WebClient = New-Object System.Net.WebClient
		$WebClient.DownloadFile($url,$output)

		Write-Host "Download feito com sucesso: "  $fileName

		$error_flag = 0
		$attempts = 0
	}
	Catch {
		Write-Host $_.Exception.Message`n
		Write-Host  "Tentando refazer o download do arquivo: " $fileName " ... Tentativa número " $attempts 
		$error_flag = 1
		$attempts += 1
	}
}
if ($attempts -eq 6){
	Write-Host "NAO FOI POSSIVEL EXTRAIR DADOS PARA O ARQUIVO " $fileName " . CONTINUANDO O PROCESSO SEM ESTA EXTRAÇAO."
}
}
