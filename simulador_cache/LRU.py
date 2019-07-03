import MemoryCache
import bitarray

'''
O mais recentemente usado fica com 1
'''

class LRU(object):
    def __init__(self, block, label):
        self.block = block
        self.label = label

    def verificacoes(self, cache, quadroA, label):
        # Verifica se está na cache
        if self.label == self.cache.lines[quadroA].label:
            aux = self.cache.lines[]

        if self.label == self.cache.lines[quadroB].label:
            aux = self.cache.lines[]