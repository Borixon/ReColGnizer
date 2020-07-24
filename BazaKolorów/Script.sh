#!/bin/bash

#bash SiteRequest.sh NCS https://www.e-paint.co.uk/NCS_1950_colour_chart.asp?NCS= 8
#bash SiteRequest.sh RalDesign https://www.e-paint.co.uk/ral_design_colours.asp?Design= 8
#bash SiteRequest.sh RalEffect https://www.e-paint.co.uk/ral_effect_colours.asp?Effect= 8
#bash SiteRequest.sh Din https://www.e-paint.co.uk/DIN_6164_colours.asp?DIN= 5
#bash SiteRequest.sh Dulux https://www.e-paint.co.uk/Dulux_Trade_colour_chart.asp?order1=2&order2=3

index=1
while [ $index -le 8 ]
do
	bash SiteToData.sh NCS_${index}
	((index=index+1))
done	

((index=1))
while [ $index -le 8 ]
do
	bash SiteToData.sh RalDesign_${index}
	((index=index+1))
done	

((index=1))
while [ $index -le 8 ]
do
	bash SiteToData.sh RalEffect_${index}
	((index=index+1))
done		

((index=1))
while [ $index -le 5 ]
do
	bash SiteToData.sh Din_${index}
	((index=index+1))
done		

bash SiteToData.sh Dulux
