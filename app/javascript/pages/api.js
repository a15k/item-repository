import { React } from '../helpers/react';
import styled from 'styled-components';
import Interactions from './interactions';
import Tokens from './tokens';

const Divider = styled.hr`
border-width: 5px;
border-radius: 3px;
`;


const Api = () => (
  <div>
    <Tokens />
    <Divider />
    <Interactions />
  </div>
);

export default Api;
