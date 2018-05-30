import styled from 'styled-components';

const ButtonsBar = styled.div`
display: flex;
margin: 1rem 0;
justify-content: flex-end;
.btn + .btn {
  margin-left: 1rem;
}
`;

export default ButtonsBar;
