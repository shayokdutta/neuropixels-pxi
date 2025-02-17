/*
------------------------------------------------------------------

This file is part of the Open Ephys GUI
Copyright (C) 2019 Allen Institute for Brain Science and Open Ephys

------------------------------------------------------------------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#include "DataPlayer.h"

#include "../Probes/OneBoxDAC.h"

#include "../NeuropixComponents.h"

DataPlayerBackground::DataPlayerBackground() {

	spikePath = Path();

	pathTransform = spikePath.getTransformToScaleToFit(100, 65, 80, 20, false);
}


void DataPlayerBackground::paint(Graphics& g)
{
	g.setColour(Colours::lightgrey);
	g.drawRoundedRectangle(0, 0, getWidth(), getHeight(), 3.0, 2.0);

	g.setFont(20);
	g.drawText("DataPlayer", 7, 5, 150, 20, Justification::left);

	g.setColour(Colours::red);
	g.strokePath(spikePath, PathStrokeType(1.0), pathTransform);

	g.setColour(Colours::orange);
	g.setFont(15);
	//g.drawText("PROBE", 5, 38, 100, 15, Justification::centredRight);
	g.drawText("STREAM", 5, 73, 128, 15, Justification::centredRight);
	g.drawText("CHANNEL", 5, 103, 128, 15, Justification::centredRight);
	g.drawText("OUTPUT", 5, 133, 128, 15, Justification::centredRight);

}

DataPlayer::DataPlayer(OneBoxDAC* dac_)
	: dac(dac_)
{
	inputChan = 0;
	outputChan = -1;

	background = new DataPlayerBackground();

	addAndMakeVisible(background);

	int leftMargin = 140;

	playerIndex = new ComboBox();
	playerIndex->setBounds(12, 40, 120, 20);;
	playerIndex->addListener(this);
	for (int i = 1; i < 9; i++)
		playerIndex->addItem("DataPlayer " + String(i), i);
	playerIndex->setSelectedId(1, dontSendNotification);
	addAndMakeVisible(playerIndex);

	availableProbes = dac->bs->getProbes();

	probeSelector = new ComboBox();
	probeSelector->setBounds(leftMargin, 40, 110, 20);
	probeSelector->addListener(this);

	for (int i = 0; i < availableProbes.size(); i++)
	{
		Probe* currentProbe = availableProbes[i];

		if (i == 0)
			selectedProbe = currentProbe;

		probeSelector->addItem("Probe " + 
			String(currentProbe->dock), i + 1);
	}

	probeSelector->setSelectedId(1, dontSendNotification);
	addAndMakeVisible(probeSelector);

	streamSelector = new ComboBox();
	streamSelector->setBounds(leftMargin, 70, 110, 20);
	streamSelector->addListener(this);
	streamSelector->addItem("AP", StreamType::AP);
	streamSelector->addItem("LFP", StreamType::LFP);
	streamSelector->setSelectedId(1, dontSendNotification);
	addAndMakeVisible(streamSelector);

	channelSelector = new ComboBox();
	channelSelector->setBounds(leftMargin, 100, 110, 20);
	channelSelector->addListener(this);

	for (int i = 0; i < 384; i++)
		channelSelector->addItem(String(i + 1), i + 1);

	channelSelector->setSelectedId(1, dontSendNotification);
	addAndMakeVisible(channelSelector);

	outputSelector = new ComboBox();
	outputSelector->setBounds(leftMargin, 130, 110, 20);
	outputSelector->addListener(this);
	outputSelector->addItem("-", 1);

	for (int i = 0; i < 12; i++)
		outputSelector->addItem("DAC" + String(i), i + 2);
	outputSelector->setSelectedId(1, dontSendNotification);

	addAndMakeVisible(outputSelector);
}

DataPlayer::~DataPlayer()
{

		

}

void DataPlayer::resized()
{
	background->setBounds(0, 0, getWidth(), getHeight());
}

void DataPlayer::comboBoxChanged(ComboBox* comboBox)
{
	if (comboBox == probeSelector)
	{
		selectedProbe = availableProbes[comboBox->getSelectedId()];
	}
	else if (comboBox == streamSelector)
	{
		streamType = (StreamType) comboBox->getSelectedId();
	}
	else if (comboBox == channelSelector)
	{
		inputChan = comboBox->getSelectedId() - 1;
	}
	else if (comboBox == outputSelector)
	{

		if (comboBox->getSelectedId() == 1 && outputChan != -1)
		{
			dac->disableOutput(outputChan);
			outputChan = -1;
			return;
		}
		else if (comboBox->getSelectedId() > 1)
		{
			outputChan = comboBox->getSelectedId() - 2;
			dac->enableOutput(outputChan);
		}
	}

	//dac->configureDataPlayer(selectedProbe->basestation->slot,
	//	outputChan,
	//	selectedProbe->port,
	//	selectedProbe->dock,
	//	inputChan,
	//	(int) streamType);

}



void DataPlayer::saveCustomParameters(XmlElement* xml)
{
	
}


void DataPlayer::loadCustomParameters(XmlElement* xml)
{
	
}
