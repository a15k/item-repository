import styled from 'styled-components';

const ButtonsBar = styled.div`
display: flex;
margin: 1rem 0;
justify-content: flex-end;
.btn + .btn,
.btn + .surety-guard,
.surety-guard + .btn
{
  margin-left: 1rem;
}
`;

export default ButtonsBar;
