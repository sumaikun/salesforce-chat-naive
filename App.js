/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, {useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
} from 'react-native';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import {MyCustomView} from 'components/MyCustomView';
console.log('MyCustomView', MyCustomView);

const App = () => {
  const [status, setStatus] = useState(false);

  return (
    <View style={styles.container}>
      <MyCustomView
        status={status}
        onClick={(event) => {
          console.log('event', event);
          setStatus(!status);
        }}
        style={{width: 100, height: 100}}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
});

export default App;
