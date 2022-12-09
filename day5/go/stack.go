package main

type Stack struct {
	Items []string
}

func (s *Stack) Push(item string) {
	s.Items = append(s.Items, item)
}

func (s *Stack) Pop() string {
	if len(s.Items) == 0 {
		return ""
	}
	item := s.Items[len(s.Items)-1]
	s.Items = s.Items[:len(s.Items)-1]
	return item
}

func (s *Stack) PopGivenQuantity(qnt int) []string {
	if qnt > len(s.Items) {
		qnt = len(s.Items)
	}
	items := s.Items[len(s.Items)-qnt:]
	s.Items = s.Items[:len(s.Items)-qnt]
	return items
}
