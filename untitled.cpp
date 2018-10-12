/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
#include<unordered_map>
class Solution {
public:
  //hash table approach. fast lookup. O(n) time, O(n) space
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        //go through first list, store all pointers in a hashtable. go through B, if I visit a node that's been stored, return it.
        unordered_map<ListNode*, bool> map;
        //go through A
        while (headA!=NULL){
            pair<ListNode*, bool> curr_node (headA, true);
            map.insert(curr_node);
            headA = headA->next;
        }
        
        //go through B
        while (headB!=NULL){
            if (map.find(headB)!=map.end())
                return headB;
            headB = headB->next;
        }
        
        return NULL;
    }
};


//soluion without extra space, O(n)
1. Run through each linked list to get the lengths and the tails.
2. Compare the tails. If they are different (by reference, not by value), return immediately. There is no inter 
section.
3. Set two pointers to the start of each linked list.
4. Onthelongerlinkedlist,advanceitspointerbythedi erenceinlengths. 5. Now, traverse on each linked list until the pointers are the same.

ListNode *getIntersectionNode(node* headA, node* headB) {

  //get length of list A
  node* currA = headA;
  int length_A=0;
  while (currA->next!=NULL){
    length_A++;
    currA = currA->next;
  }
  length_A++;

  //get length of list B
  node* currB = headB;
  int length_B=0;
  while (currB->next!=NULL){
    length_B++;
    currB = currB->next;
  }
  length_B++;

  //tail node not the same, no intersection
  if (currA!=currB)
    return NULL;

  bool is_A_longer = false;
  currA = headA;
  currB = headB;

  if (length_A>length_B)
    is_A_longer = true;

  if (is_A_longer){
    int diff = length_A-length_B;
    for (int i=0;i<diff;i++)
      currA = currA->next;
  }
  else {
    int diff = length_B-length_A;
    for (int i=0;i<diff;i++)
      currB = currB->next;
  }

  while (currA!=currB){
    currA = currA->next;
    currB=currB->next;
  }
  return currA;
}