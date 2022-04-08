# Import scipy.special for the sigmoid function expit()
from operator import index
import scipy.special, numpy
import matplotlib.pyplot as plt
import scipy.io as spio


# Neural network class definition
class NeuralNetwork:
    # Init the network, this gets run whenever we make a new instance of this class
    def __init__ (self, input_nodes, hidden_nodes, output_nodes, learning_rate):  #NB Needs double underscore to initialise in this fashion 
        # Set the number of nodes in each input, hidden and output layer
        self.i_nodes = input_nodes
        self.h_nodes = hidden_nodes
        self.o_nodes = output_nodes

        # Weight matrices, wih (Weight, input -> hidden) and who (Weight, hidden -> output)
        self.wih = numpy.random.normal(0.0, pow(self.h_nodes, -0.5), (self.h_nodes, self.i_nodes))
        self.who = numpy.random.normal(0.0, pow(self.o_nodes, -0.5), (self.o_nodes, self.h_nodes))
        # Set the learning rate
        self.lr = learning_rate

        # Set the activation function, the logistic sigmoid
        self.activation_function = lambda x: scipy.special.expit(x)
    
    # Train the network using back-propagation of errors
    def train(self, inputs_list, targets_list):
        # Convert inputs into 2D arrays
        inputs_array = numpy.array(inputs_list, ndmin=2).T
        targets_array = numpy.array(targets_list, ndmin=2).T
       
        # Calculate signals into hidden layer
        hidden_inputs = numpy.dot(self.wih, inputs_array)
       
        # Calculate the signals emerging from hidden layer
        hidden_outputs = self.activation_function(hidden_inputs)
       
        # Calculate signals into final output layer
        final_inputs = numpy.dot(self.who, hidden_outputs)
       
        # Calculate the signals emerging from final output layer
        final_outputs = self.activation_function(final_inputs)
       
        # Current error is (target - actual)
        output_errors = targets_array - final_outputs
       
        # Hidden layer errors are the output errors, split by the weights, recombined at hidden nodes
        hidden_errors = numpy.dot(self.who.T, output_errors)
       
        # Update the weights for the links between the hidden and output layers
        self.who += self.lr * numpy.dot((output_errors * final_outputs * (1.0 - final_outputs)),
        numpy.transpose(hidden_outputs))
       
        # Update the weights for the links between the input and hidden layers
        self.wih += self.lr * numpy.dot((hidden_errors * hidden_outputs * (1.0 - hidden_outputs)),
        numpy.transpose(inputs_array))

    # Query the network
    def query(self, inputs_list):
        # Convert the inputs list into a 2D array
        inputs_array = numpy.array(inputs_list, ndmin=2).T
     
        # Calculate signals into hidden layer
        hidden_inputs = numpy.dot(self.wih, inputs_array)  
     
        # Calculate output from the hidden layer
        hidden_outputs = self.activation_function(hidden_inputs)
     
        # Calculate signals into final layer
        final_inputs = numpy.dot(self.who, hidden_outputs)
     
        # Calculate outputs from the final layer
        final_outputs =self.activation_function(final_inputs)
       
        return final_outputs


#Load base data into python

#To switch  to filtered data can simply change the file that is loaded, handles are the same
#mat = spio.loadmat('trainingseg.mat', squeeze_me=True)


LoadData = spio.loadmat('DataStack.mat',squeeze_me=True)
LoadDataShort = spio.loadmat('DataStackShort.mat', squeeze_me=True)


LoadIndex = spio.loadmat('IndexMatRand.mat', squeeze_me=True)

### Can use this to omit certain data. no other changes are neccesary. This removes one (Needs preprocessing in matlab)
#LoadIndex = spio.loadmat('IndexMatRand_234.mat', squeeze_me=True)

#Data = LoadData['DataStack']   # 24 along, stacked downwards
Data = LoadDataShort['DataStackShort']   # 22 along, stacked downwards

IndexAll = LoadIndex['IndexMatRand'] # Random order, Index;Class



IndexLen = len(IndexAll[0])
DataLen = len(Data[0])

IndexTrain = IndexAll[:,0 : round(IndexLen * 0.8)]
IndexTest = IndexAll[:,round(IndexLen * 0.8) : -1]

binwidth = 800
#Set network parameters
input_nodes = binwidth*DataLen  #24 for full stack, 22 for short
hidden_nodes = 10000
output_nodes = 4
learning_rate = 0.5
trainingIt = 1

#Initiate MLP 
SpikesortMLP = NeuralNetwork(input_nodes, hidden_nodes, output_nodes, learning_rate)

#Train many times
for n in list(range(trainingIt)):
    #Train network using known index positions
    classidx = 0
    for Spikeindex in IndexTrain[0]:
        #Dsegment = d[int(Spikeindex - binwidth/2) : int(Spikeindex + binwidth/2)]
        Dsegment = Data[Spikeindex : int(Spikeindex + binwidth)] # FROM INSPECTION Bin starts just before spike
        
        #Need to multiplex the data in Dsegment so that all 22 elements are input into the MLP for each sample in the bin
        DsegmentLong = numpy.concatenate(Dsegment, 0)

        ClassLabel = IndexAll[1,classidx]
        targets = numpy.zeros(output_nodes) + 0.01
        targets[ClassLabel-1] = 0.99   #Account for 0 indexing in python
        
        SpikesortMLP.train(DsegmentLong,targets)

        classidx = classidx + 1



#Query network to test performance
#Load testing data
#mat = spio.loadmat('testingseg.mat', squeeze_me=True)
#mat = spio.loadmat('testingsegFILTERED.mat', squeeze_me=True)
#Indextest = mat['itest']
#Classtest = mat['ctest']

#Initialise score for simple performance metric
score = []
classidx = 0

#save data to confusion matrix for in depth analysis of incorrect classifications
confusionmat = numpy.zeros((output_nodes,output_nodes))

#for Spikeindex in IndexTest[0]:
for Spikeindex in IndexTest[0]:
    #Dsegment = d[int(Spikeindex - binwidth/2) : int(Spikeindex + binwidth/2)]
    Dsegment = Data[Spikeindex : int(Spikeindex + binwidth)] 
    DsegmentLong = numpy.concatenate(Dsegment, 0)
    #Query network
    netOut = SpikesortMLP.query(DsegmentLong)
    ClassNet = numpy.argmax(netOut) + 1 #Account for 0 indexing in python
    #Verify accuracy
    ClassLabel = IndexAll[1,classidx]
    #ClassLabel = Classtest[classidx]
    if ClassNet == ClassLabel:
        score.append(1)
    else:
        score.append(0)
        print('Misslabeled, thought Class', ClassLabel, 'was Class', ClassNet)

    confusionmat[ClassNet-1, ClassLabel-1]  = confusionmat[ClassNet-1, ClassLabel-1] + 1 

    classidx = classidx + 1
scorearray = numpy.asarray(score)
scorePerc =  scorearray.sum()/scorearray.size * 100
print('Total accuracy:', scorePerc, '%')


savesuffix = "MLP"
savename = "ConfusionMat" + savesuffix
#numpy.save(savename, confusionmat)
